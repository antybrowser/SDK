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

public class AntybrowserClient {
    private final String apiKey;
    private final String baseUrl;
    private final HttpClient httpClient;
    private final Gson gson = new Gson();

    public AntybrowserClient(String apiKey) {
        this(apiKey, 5173, null);
    }

    public AntybrowserClient(String apiKey, int port) {
        this(apiKey, port, null);
    }

    public AntybrowserClient(String apiKey, int port, String baseUrl) {
        this.apiKey = apiKey;
        this.baseUrl = baseUrl != null ? baseUrl : "http://127.0.0.1:" + port;
        this.httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(30))
                .build();
    }

    // ─── Profiles ────────────────────────────────────────────────────────

    public List<Profile> getProfiles() {
        return get("/api/profiles", new TypeToken<List<Profile>>(){}.getType());
    }

    public Profile createProfile(Map<String, Object> data) {
        return post("/api/profiles", data, Profile.class);
    }

    public Profile createProfile(CreateProfileRequest data) {
        return post("/api/profiles", data, Profile.class);
    }

    public Profile updateProfile(int id, Map<String, Object> data) {
        return put("/api/profiles/" + id, data, Profile.class);
    }

    public Profile updateProfile(int id, CreateProfileRequest data) {
        return put("/api/profiles/" + id, data, Profile.class);
    }

    public Map<String, Object> deleteProfile(int id) {
        return delete("/api/profiles/" + id, new TypeToken<Map<String, Object>>(){}.getType());
    }

    public StartProfileResponse startProfile(int id) {
        return startProfile(id, false);
    }

    /**
     * Starts a profile. Pass {@code headless = true} to run it without a
     * visible window (stealth headless tier; same fingerprint as a headed
     * launch, no automation-only switches).
     */
    public StartProfileResponse startProfile(int id, boolean headless) {
        Map<String, Object> body = new HashMap<>();
        if (headless) {
            body.put("headless", true);
        }
        return post("/api/profiles/" + id + "/start", body, StartProfileResponse.class);
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

    private <T> T post(String path, Object body, java.lang.reflect.Type type) {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(baseUrl + path))
                .header("x-api-key", apiKey)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(gson.toJson(body)))
                .build();
        return send(request, type);
    }

    private <T> T put(String path, Object body, java.lang.reflect.Type type) {
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
                throw new AntybrowserException(
                    "API request failed with status " + code, code, body
                );
            }

            if (body == null || body.isBlank()) {
                return null;
            }

            return gson.fromJson(body, type);
        } catch (AntybrowserException e) {
            throw e;
        } catch (IOException e) {
            throw new AntybrowserException("Failed to connect to Antybrowser: " + e.getMessage());
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new AntybrowserException("Request interrupted: " + e.getMessage());
        }
    }
}
