<?php

declare(strict_types=1);

namespace AntyBrowser\SDK;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;

final class AntyBrowserClient
{
    private Client $httpClient;
    private string $apiKey;
    private string $baseUrl;

    public function __construct(string $apiKey, ?int $port = null, ?string $baseUrl = null, ?Client $httpClient = null)
    {
        $this->apiKey = $apiKey;
        $this->baseUrl = $baseUrl ?? sprintf('http://127.0.0.1:%d', $port ?? 5173);
        $this->httpClient = $httpClient ?? new Client([
            'base_uri' => $this->baseUrl,
            'headers' => [
                'x-api-key' => $apiKey,
                'Content-Type' => 'application/json',
            ],
            'timeout' => 30,
        ]);
    }

    // ─── System ──────────────────────────────────────────────────────────

    public function getStatus(): array
    {
        return $this->get('/api/status');
    }

    public function getSettings(): array
    {
        return $this->get('/api/settings');
    }

    public function getSyncStatus(): SyncStatus
    {
        return SyncStatus::fromArray($this->get('/api/sync/status'));
    }

    public function refreshSync(?int $profileId = null): array
    {
        $body = $profileId !== null ? ['profileId' => $profileId] : [];
        return $this->post('/api/sync/refresh', $body);
    }

    // ─── Profiles ────────────────────────────────────────────────────────

    /** @return Profile[] */
    public function getProfiles(): array
    {
        return array_map(fn(array $d) => Profile::fromArray($d), $this->get('/api/profiles'));
    }

    public function createProfile(array $data): Profile
    {
        return Profile::fromArray($this->post('/api/profiles', $data));
    }

    public function updateProfile(int $id, array $data): Profile
    {
        return Profile::fromArray($this->put("/api/profiles/$id", $data));
    }

    public function deleteProfile(int $id): array
    {
        return $this->delete("/api/profiles/$id");
    }

    public function startProfile(int $id): array
    {
        return $this->post("/api/profiles/$id/start", []);
    }

    public function stopProfile(int $id): array
    {
        return $this->post("/api/profiles/$id/stop", []);
    }

    public function duplicateProfile(int $id, array $options = []): Profile
    {
        return Profile::fromArray($this->post("/api/profiles/$id/duplicate", $options));
    }

    // ─── Automations ─────────────────────────────────────────────────────

    /** @return Automation[] */
    public function getAutomations(): array
    {
        return array_map(fn(array $d) => Automation::fromArray($d), $this->get('/api/automations'));
    }

    public function runAutomation(int $id, array $data): array
    {
        return $this->post("/api/automations/$id/run", $data);
    }

    // ─── Groups ──────────────────────────────────────────────────────────

    /** @return Group[] */
    public function getGroups(): array
    {
        return array_map(fn(array $d) => Group::fromArray($d), $this->get('/api/groups'));
    }

    public function createGroup(array $data): Group
    {
        return Group::fromArray($this->post('/api/groups', $data));
    }

    public function updateGroup(int $id, array $data): Group
    {
        return Group::fromArray($this->put("/api/groups/$id", $data));
    }

    public function deleteGroup(int $id): void
    {
        $this->delete("/api/groups/$id");
    }

    // ─── Proxies ─────────────────────────────────────────────────────────

    /** @return Proxy[] */
    public function getProxies(): array
    {
        return array_map(fn(array $d) => Proxy::fromArray($d), $this->get('/api/proxies'));
    }

    public function createProxy(array $data): Proxy
    {
        return Proxy::fromArray($this->post('/api/proxies', $data));
    }

    public function checkProxy(array $data): ProxyCheckResult
    {
        $result = $this->post('/api/proxies/check', $data);
        return new ProxyCheckResult(
            success: $result['success'] ?? false,
            details: $result['details'] ?? null,
            errorMessage: $result['errorMessage'] ?? null,
        );
    }

    /** @return ProxyCheckResult[] */
    public function checkProxiesBulk(array $proxies): array
    {
        $result = $this->post('/api/proxies/check-bulk', ['proxies' => $proxies]);
        $results = $result['results'] ?? $result;
        return array_map(
            fn(array $r) => new ProxyCheckResult(
                success: $r['success'] ?? false,
                details: $r['details'] ?? null,
                errorMessage: $r['errorMessage'] ?? null,
            ),
            $results
        );
    }

    public function deleteProxy(int $id): void
    {
        $this->delete("/api/proxies/$id");
    }

    // ─── Extensions ──────────────────────────────────────────────────────

    /** @return Extension[] */
    public function getExtensions(): array
    {
        return array_map(fn(array $d) => Extension::fromArray($d), $this->get('/api/extensions'));
    }

    public function deleteExtension(int $id): void
    {
        $this->delete("/api/extensions/$id");
    }

    /** @return Extension[] */
    public function getProfileExtensions(int $profileId, bool $details = false): array
    {
        return array_map(
            fn(array $d) => Extension::fromArray($d),
            $this->get("/api/profiles/$profileId/extensions?details=" . ($details ? 'true' : 'false'))
        );
    }

    public function setProfileExtensions(int $profileId, array $extensionIds): array
    {
        return $this->post("/api/profiles/$profileId/extensions", ['extensionIds' => $extensionIds]);
    }

    // ─── HTTP Helpers ────────────────────────────────────────────────────

    private function get(string $path): array
    {
        try {
            $response = $this->httpClient->get($path);
            return $this->handleResponse($response);
        } catch (GuzzleException $e) {
            throw new AntyBrowserError("Failed to connect to AntyBrowser: {$e->getMessage()}");
        }
    }

    private function post(string $path, array $body): array
    {
        try {
            $response = $this->httpClient->post($path, ['json' => $body]);
            return $this->handleResponse($response);
        } catch (GuzzleException $e) {
            throw new AntyBrowserError("Failed to connect to AntyBrowser: {$e->getMessage()}");
        }
    }

    private function put(string $path, array $body): array
    {
        try {
            $response = $this->httpClient->put($path, ['json' => $body]);
            return $this->handleResponse($response);
        } catch (GuzzleException $e) {
            throw new AntyBrowserError("Failed to connect to AntyBrowser: {$e->getMessage()}");
        }
    }

    private function delete(string $path): array
    {
        try {
            $response = $this->httpClient->delete($path);
            return $this->handleResponse($response);
        } catch (GuzzleException $e) {
            throw new AntyBrowserError("Failed to connect to AntyBrowser: {$e->getMessage()}");
        }
    }

    private function handleResponse($response): array
    {
        $statusCode = $response->getStatusCode();
        $body = (string) $response->getBody();

        if ($statusCode < 200 || $statusCode >= 300) {
            throw new AntyBrowserError(
                message: "API request failed with status $statusCode",
                statusCode: $statusCode,
                responseBody: $body,
            );
        }

        if ($body === '' || $body === 'null') {
            return [];
        }

        $decoded = json_decode($body, true);
        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new AntyBrowserError(
                message: 'Invalid JSON response from API',
                statusCode: $statusCode,
                responseBody: $body,
            );
        }

        return $decoded;
    }
}
