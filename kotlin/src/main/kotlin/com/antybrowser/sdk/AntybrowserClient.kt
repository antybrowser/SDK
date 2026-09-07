package com.antybrowser.sdk

import com.google.gson.Gson
import org.apache.http.client.methods.*
import org.apache.http.entity.StringEntity
import org.apache.http.impl.client.HttpClients
import org.apache.http.util.EntityUtils

class AntybrowserClient(
    private val apiKey: String,
    private val baseUrl: String = "http://127.0.0.1:5173"
) : AutoCloseable {
    private val client = HttpClients.createDefault()
    private val gson = Gson()

    // System
    fun getStatus(): ApiResponse = get("/api/status")
    fun getSettings(): Settings = get("/api/settings")
    fun getSyncStatus(): SyncStatus = get("/api/sync/status")
    fun refreshSync(profileId: String? = null): ApiResponse {
        val body = if (profileId != null) mapOf("profileId" to profileId) else emptyMap<String, Any>()
        return post("/api/sync/refresh", body)
    }

    // Profiles
    fun getProfiles(): List<Profile> = get("/api/profiles")
    fun createProfile(request: CreateProfileRequest): Profile = post("/api/profiles", request)
    fun updateProfile(id: Int, data: Map<String, Any>): Profile = put("/api/profiles/$id", data)
    fun deleteProfile(id: Int): ApiResponse = delete("/api/profiles/$id")
    fun startProfile(id: Int): StartProfileResponse = post("/api/profiles/$id/start", emptyMap<String, Any>())
    fun stopProfile(id: Int): ApiResponse = post("/api/profiles/$id/stop", emptyMap<String, Any>())
    fun duplicateProfile(id: Int, name: String? = null): Profile {
        val body = if (name != null) mapOf("name" to name) else emptyMap<String, Any>()
        return post("/api/profiles/$id/duplicate", body)
    }

    // Automations
    fun getAutomations(): List<Automation> = get("/api/automations")
    fun runAutomation(id: Int, profileId: Int): RunAutomationResult = post("/api/automations/$id/run", mapOf("profileId" to profileId))

    // Groups
    fun getGroups(): List<Group> = get("/api/groups")
    fun createGroup(request: CreateGroupRequest): Group = post("/api/groups", request)
    fun updateGroup(id: Int, data: Map<String, Any>): Group = put("/api/groups/$id", data)
    fun deleteGroup(id: Int): ApiResponse = delete("/api/groups/$id")

    // Proxies
    fun getProxies(): List<Proxy> = get("/api/proxies")
    fun createProxy(request: CreateProxyRequest): Proxy = post("/api/proxies", request)
    fun checkProxy(data: Map<String, Any>): ProxyCheckResult = post("/api/proxies/check", data)
    fun deleteProxy(id: Int): ApiResponse = delete("/api/proxies/$id")

    // Extensions
    fun getExtensions(): List<Extension> = get("/api/extensions")
    fun deleteExtension(id: Int): ApiResponse = delete("/api/extensions/$id")
    fun getProfileExtensions(profileId: Int): List<Extension> = get("/api/profiles/$profileId/extensions")
    fun setProfileExtensions(profileId: Int, extensionIds: List<Int>): ApiResponse = post("/api/profiles/$profileId/extensions", mapOf("extensionIds" to extensionIds))

    // HTTP helpers
    private inline fun <reified T> get(path: String): T = executeRequest(HttpGet("$baseUrl$path")) { gson.fromJson(it, T::class.java) }
    private inline fun <reified T> post(path: String, body: Any): T {
        val request = HttpPost("$baseUrl$path").apply {
            setEntity(StringEntity(gson.toJson(body)))
            addHeader("Content-Type", "application/json")
        }
        return executeRequest(request) { gson.fromJson(it, T::class.java) }
    }
    private inline fun <reified T> put(path: String, body: Any): T {
        val request = HttpPut("$baseUrl$path").apply {
            setEntity(StringEntity(gson.toJson(body)))
            addHeader("Content-Type", "application/json")
        }
        return executeRequest(request) { gson.fromJson(it, T::class.java) }
    }
    private inline fun <reified T> delete(path: String): T = executeRequest(HttpDelete("$baseUrl$path")) { gson.fromJson(it, T::class.java) }

    private fun <T> executeRequest(request: HttpUriRequest, parser: (String) -> T): T {
        request.addHeader("x-api-key", apiKey)
        val response = client.execute(request)
        val statusCode = response.statusLine.statusCode
        val body = EntityUtils.toString(response.entity)
        if (statusCode !in 200..299) throw AntybrowserException("API request failed with status $statusCode", statusCode, body)
        return parser(body)
    }

    override fun close() { client.close() }
}
