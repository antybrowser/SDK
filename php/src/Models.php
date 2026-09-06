<?php

declare(strict_types=1);

namespace Antybrowser\SDK;

final class Profile
{
    public function __construct(
        public readonly int $id,
        public readonly string $name,
        public readonly ?string $directoryName = null,
        public readonly ?int $groupId = null,
        public readonly ?int $proxyId = null,
        public readonly ?string $browserType = null,
        public readonly ?string $browserVersion = null,
        public readonly ?string $osFingerprint = null,
        public readonly ?string $screenResolution = null,
        public readonly ?string $language = null,
        public readonly ?string $acceptLanguage = null,
        public readonly ?string $timezone = null,
        public readonly ?bool $useFingerprint = null,
        public readonly ?string $fingerprintId = null,
        public readonly ?bool $restoreSession = null,
        public readonly ?bool $lowBandwidth = null,
        public readonly ?string $notes = null,
        public readonly ?string $startUrl = null,
        public readonly ?string $customFlags = null,
        public readonly ?string $status = null,
        public readonly ?bool $needsSync = null,
        public readonly ?int $lastPid = null,
        public readonly ?int $debugPort = null,
        public readonly ?string $createdAt = null,
        public readonly ?string $updatedAt = null,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            id: $data['id'],
            name: $data['name'],
            directoryName: $data['directoryName'] ?? null,
            groupId: $data['groupId'] ?? null,
            proxyId: $data['proxyId'] ?? null,
            browserType: $data['browserType'] ?? null,
            browserVersion: $data['browserVersion'] ?? null,
            osFingerprint: $data['osFingerprint'] ?? null,
            screenResolution: $data['screenResolution'] ?? null,
            language: $data['language'] ?? null,
            acceptLanguage: $data['acceptLanguage'] ?? null,
            timezone: $data['timezone'] ?? null,
            useFingerprint: $data['useFingerprint'] ?? null,
            fingerprintId: $data['fingerprintId'] ?? null,
            restoreSession: $data['restoreSession'] ?? null,
            lowBandwidth: $data['lowBandwidth'] ?? null,
            notes: $data['notes'] ?? null,
            startUrl: $data['startUrl'] ?? null,
            customFlags: $data['customFlags'] ?? null,
            status: $data['status'] ?? null,
            needsSync: $data['needsSync'] ?? null,
            lastPid: $data['lastPid'] ?? null,
            debugPort: $data['debugPort'] ?? null,
            createdAt: $data['createdAt'] ?? null,
            updatedAt: $data['updatedAt'] ?? null,
        );
    }
}

final class Proxy
{
    public function __construct(
        public readonly int $id,
        public readonly ?string $name = null,
        public readonly ?string $type = null,
        public readonly ?string $host = null,
        public readonly ?int $port = null,
        public readonly ?string $username = null,
        public readonly ?string $status = null,
        public readonly ?string $countryCode = null,
        public readonly ?string $ip = null,
        public readonly ?string $country = null,
        public readonly ?string $timezone = null,
        public readonly ?string $asn = null,
        public readonly ?string $isp = null,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            id: $data['id'],
            name: $data['name'] ?? null,
            type: $data['type'] ?? null,
            host: $data['host'] ?? null,
            port: $data['port'] ?? null,
            username: $data['username'] ?? null,
            status: $data['status'] ?? null,
            countryCode: $data['countryCode'] ?? null,
            ip: $data['ip'] ?? null,
            country: $data['country'] ?? null,
            timezone: $data['timezone'] ?? null,
            asn: $data['asn'] ?? null,
            isp: $data['isp'] ?? null,
        );
    }
}

final class Group
{
    public function __construct(
        public readonly int $id,
        public readonly string $name,
        public readonly ?string $description = null,
        public readonly ?string $color = null,
        public readonly ?int $displayOrder = null,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            id: $data['id'],
            name: $data['name'],
            description: $data['description'] ?? null,
            color: $data['color'] ?? null,
            displayOrder: $data['displayOrder'] ?? null,
        );
    }
}

final class Extension
{
    public function __construct(
        public readonly int $id,
        public readonly string $name,
        public readonly ?string $path = null,
        public readonly ?string $description = null,
        public readonly ?string $icon = null,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            id: $data['id'],
            name: $data['name'],
            path: $data['path'] ?? null,
            description: $data['description'] ?? null,
            icon: $data['icon'] ?? null,
        );
    }
}

final class Automation
{
    public function __construct(
        public readonly int $id,
        public readonly string $name,
        public readonly ?string $description = null,
        public readonly ?string $status = null,
        public readonly ?string $lastRun = null,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            id: $data['id'],
            name: $data['name'],
            description: $data['description'] ?? null,
            status: $data['status'] ?? null,
            lastRun: $data['lastRun'] ?? null,
        );
    }
}

final class SyncStatus
{
    public function __construct(
        public readonly int $total,
        public readonly int $completed,
        public readonly bool $isSyncing,
        public readonly array $active = [],
        public readonly array $errors = [],
        public readonly array $progress = [],
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            total: $data['total'] ?? 0,
            completed: $data['completed'] ?? 0,
            isSyncing: $data['isSyncing'] ?? false,
            active: $data['active'] ?? [],
            errors: $data['errors'] ?? [],
            progress: $data['progress'] ?? [],
        );
    }
}

final class ProxyCheckResult
{
    public function __construct(
        public readonly bool $success,
        public readonly ?array $details = null,
        public readonly ?string $errorMessage = null,
    ) {}
}
