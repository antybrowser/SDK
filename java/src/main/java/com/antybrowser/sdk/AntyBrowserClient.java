package com.antybrowser.sdk;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AntyBrowserClient {
    private final String apiKey;
    private final String baseUrl;
    private final HttpClient httpClient;
    private final Gson gson = new Gson();

    public AntyBrowserClient(String apiKey) {
        this(apiKey, 5173, null);
    }

    public AntyBrowserClient(String apiKey, int port) {
        this(apiKey, port, null);
    }

    public AntyBrowserClient(String apiKey, int port, String baseUrl) {
        this.apiKey = apiKey;
        this.baseUrl = baseUrl != null ? baseUrl : "http://127.0.0.1:" + port;
        this.httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(30))
                .build();
    }

    // ─── System ──────────────────────────────────────────────────────────

    public Map<String, Object> getStatus() {
        return get("/api/status", new TypeToken<Map<String, Object>>(){}.getType());
    }

    public Map<String, Object> getSettings() {
        return get("/api/settings", new TypeToken<Map<String, Object>>(){}.getType());
    }

    public Map<String, Object> getSyncStatus() {
        return get("/api/sync/status", new TypeToken<Map<String, Object>>(){}.getType());
    }

    public Map<String, Object> refreshSync(Integer profileId) {
        Map<String, Object> body = new HashMap<>();
        if (profileId != null) body.put("profileId", profileId);
        return post("/api/sync/refresh", body, new TypeToken<Map<String, Object>>(){}.getType());
    }

    // ─── Profiles ────────────────────────────────────────────────────────

    public List<Profile> getProfiles() {
        return get("/api/profiles", new TypeToken<List<Profile>>(){}.getType());
    }

    public Profile createProfile(Map<String, Object> data) {
        return post("/api/profiles", data, Profile.class);
    }

    public Profile updateProfile(int id, Map<String, Object> data) {
        return put("/api/profiles/" + id, data, Profile.class);
    }

    public Map<String, Object> deleteProfile(int id) {
        return delete("/api/profiles/" + id, new TypeToken<Map<String, Object>>(){}.getType());
    }

    public StartProfileResponse startProfile(int id) {
        return post("/api/profiles/" + id + "/start", new HashMap<>(), StartProfileResponse.class);
    }

    public Map<String, Object> stopProfile(int id) {
        return post("/api/profiles/" + id + "/stop", new HashMap<>(), new TypeToken<Map<String, Object>>(){}.getType());
    }

    public Profile duplicateProfile(int id, Map<String, Object> options) {
        return post("/api/profiles/" + id + "/duplicate", options != null ? options : new HashMap<>(), Profile.class);
    }

    // ─── Automations ─────────────────────────────────────────────────────

    public List<Automation> getAutomations() {
        return get("/api/automations", new TypeToken<List<Automation>>(){}.getType());
    }

    public Map<String, Object> runAutomation(int id, Map<String, Object> data) {
        return post("/api/automations/" + id + "/run", data, new TypeToken<Map<String, Object>>(){}.getType());
    }

    // ─── Groups ──────────────────────────────────────────────────────────

    public List<Group> getGroups() {
        return get("/api/groups", new TypeToken<List<Group>>(){}.getType());
    }

    public Group createGroup(Map<String, Object> data) {
        return post("/api/groups", data, Group.class);
    }

    public Group updateGroup(int id, Map<String, Object> data) {
        return put("/api/groups/" + id, data, Group.class);
    }

    public void deleteGroup(int id) {
        delete("/api/groups/" + id, new TypeToken<Map<String, Object>>(){}.getType());
    }

    // ─── Proxies ─────────────────────────────────────────────────────────

    public List<Proxy> getProxies() {
        return get("/api/proxies", new TypeToken<List<Proxy>>(){}.getType());
    }

    public Proxy createProxy(Map<String, Object> data) {
        return post("/api/proxies", data, Proxy.class);
    }

    public ProxyCheckResult checkProxy(Map<String, Object> data) {
        return post("/api/proxies/check", data, ProxyCheckResult.class);
    }

    public List<ProxyCheckResult> checkProxiesBulk(List<Object> proxies) {
        Map<String, Object> body = new HashMap<>();
        body.put("proxies", proxies);
        Map<String, Object> result = post("/api/proxies/check-bulk", body, new TypeToken<Map<String, Object>>(){}.getType());
        Object results = result.get("results");
        if (results instanceof List) {
            return gson.fromJson(gson.toJson(results), new TypeToken<List<ProxyCheckResult>>(){}.getType());
        }
        return List.of();
    }

    public void deleteProxy(int id) {
        delete("/api/proxies/" + id, new TypeToken<Map<String, Object>>(){}.getType());
    }

    // ─── Extensions ──────────────────────────────────────────────────────

    public List<Extension> getExtensions() {
        return get("/api/extensions", new TypeToken<List<Extension>>(){}.getType());
    }

    public void deleteExtension(int id) {
        delete("/api/extensions/" + id, new TypeToken<Map<String, Object>>(){}.getType());
    }

    public List<Extension> getProfileExtensions(int profileId, boolean details) {
        return get("/api/profiles/" + profileId + "/extensions?details=" + details, new TypeToken<List<Extension>>(){}.getType());
    }

    public Map<String, Object> setProfileExtensions(int profileId, List<Integer> extensionIds) {
        Map<String, Object> body = new HashMap<>();
        body.put("extensionIds", extensionIds);
        return post("/api/profiles/" + profileId + "/extensions", body, new TypeToken<Map<String, Object>>(){}.getType());
    }

    // ─── HTTP Helpers ────────────────────────────────────────────────────

    private <T> T get(String path, java.lang.reflect.Type type) {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(baseUrl + path))
                .header("x-api-key", apiKey)
                .header("Content-Type", "application/json")
                .GET()
                .build();
        return send(request, type);
    }

    private <T> T post(String path, Map<String, Object> body, java.lang.reflect.Type type) {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(baseUrl + path))
                .header("x-api-key", apiKey)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(gson.toJson(body)))
                .build();
        return send(request, type);
    }

    private <T> T put(String path, Map<String, Object> body, java.lang.reflect.Type type) {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(baseUrl + path))
                .header("x-api-key", apiKey)
                .header("Content-Type", "application/json")
                .PUT(HttpRequest.BodyPublishers.ofString(gson.toJson(body)))
                .build();
        return send(request, type);
    }

    private <T> T delete(String path, java.lang.reflect.Type type) {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(baseUrl + path))
                .header("x-api-key", apiKey)
                .header("Content-Type", "application/json")
                .DELETE()
                .build();
        return send(request, type);
    }

    private <T> T send(HttpRequest request, java.lang.reflect.Type type) {
        try {
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            int code = response.statusCode();
            String body = response.body();

            if (code < 200 || code >= 300) {
                throw new AntyBrowserException(
                    "API request failed with status " + code, code, body
                );
            }

            if (body == null || body.isBlank()) {
                return null;
            }

            return gson.fromJson(body, type);
        } catch (AntyBrowserException e) {
            throw e;
        } catch (IOException e) {
            throw new AntyBrowserException("Failed to connect to AntyBrowser: " + e.getMessage());
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new AntyBrowserException("Request interrupted: " + e.getMessage());
        }
    }
}
