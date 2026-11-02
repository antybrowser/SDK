package com.antybrowser.sdk

data class ApiResponse(val success: Boolean = false, val message: String? = null, val data: Any? = null)
data class StartProfileResponse(val success: Boolean = false, val data: Map<String, Any> = emptyMap())

data class Profile(
    val id: Int = 0,
    val userId: Int? = null,
    val userGuid: String? = null,
    val name: String? = null,
    val directoryName: String? = null,
    val groupId: Int? = null,
    val proxyId: Int? = null,
    val browserType: String? = null,
    val browserVersion: String? = null,
    val osFingerprint: String? = null,
    val screenResolution: String? = null,
    val screenMaximizable: Boolean? = null,
    val language: String? = null,
    val acceptLanguage: String? = null,
    val timezone: String? = null,
    val useFingerprint: Boolean? = null,
    // Server-owned noise seed. Read-only - never sent on create/update.
    val fingerprintId: String? = null,
    val platformVersion: String? = null,
    val brandVersion: String? = null,
    val engineVersion: String? = null,
    val gpuVendor: String? = null,
    val gpuModel: String? = null,
    val hardwareConcurrency: Any? = null,
    val deviceMemory: Any? = null,
    val deviceScaleFactor: Any? = null,
    val mobileModel: String? = null,
    val mobileVersion: Any? = null,
    val chPlatform: String? = null,
    val chPlatformVersion: String? = null,
    val chArch: String? = null,
    val chBitness: String? = null,
    val chModel: String? = null,
    val chMobile: Any? = null,
    val disableSpoofing: String? = null,
    val locationMode: String? = null,
    val locationLatitude: String? = null,
    val locationLongitude: String? = null,
    val locationAccuracy: String? = null,
    val userAgent: String? = null,
    val restoreSession: Boolean? = null,
    val lowBandwidth: Boolean? = null,
    val notes: String? = null,
    val startUrl: String? = null,
    val customFlags: String? = null,
    val status: String? = null,
    val statusMachineId: String? = null,
    val statusHeartbeatAt: String? = null,
    val needsSync: Boolean? = null,
    val lastPid: Int? = null,
    val debugPort: Int? = null,
    val tabsSnapshot: String? = null,
    val createdAt: String? = null,
    val updatedAt: String? = null
)

// Payload for creating or updating a profile. Every field is optional except name.
// fingerprintId is server-generated and tlsGrease is retired, so neither is part of this request.
data class CreateProfileRequest(
    val name: String,
    val directoryName: String? = null,
    val groupId: Int? = null,
    val proxyId: Int? = null,
    // Chrome, Edge, Opera, Vivaldi or Brave. Chromium is not a brand - it folds to Chrome.
    val browserType: String? = null,
    val browserVersion: String? = null,
    val osFingerprint: String? = null,
    val screenResolution: String? = null,
    val screenMaximizable: Boolean? = null,
    val language: String? = null,
    val acceptLanguage: String? = null,
    val timezone: String? = null,
    val useFingerprint: Boolean? = null,
    val platformVersion: String? = null,
    val brandVersion: String? = null,
    val engineVersion: String? = null,
    val gpuVendor: String? = null,
    val gpuModel: String? = null,
    val hardwareConcurrency: Any? = null,
    val deviceMemory: Any? = null,
    val deviceScaleFactor: Any? = null,
    val mobileModel: String? = null,
    val mobileVersion: Any? = null,
    val chPlatform: String? = null,
    val chPlatformVersion: String? = null,
    val chArch: String? = null,
    val chBitness: String? = null,
    val chModel: String? = null,
    val chMobile: Any? = null,
    val disableSpoofing: String? = null,
    // "" (off), "proxy" (based on the exit IP) or "manual".
    val locationMode: String? = null,
    val locationLatitude: String? = null,
    val locationLongitude: String? = null,
    val locationAccuracy: String? = null,
    val restoreSession: Boolean? = null,
    val lowBandwidth: Boolean? = null,
    val notes: String? = null,
    val startUrl: String? = null,
    val customFlags: String? = null,
    val status: String? = null,
    val hidden: Boolean? = null
)

data class Automation(val id: Int = 0, val name: String = "", val description: String? = null, val status: String? = null)
data class RunAutomationResult(val success: Boolean = false, val message: String? = null)
data class Group(val id: Int = 0, val name: String = "", val description: String? = null, val color: String? = null)
data class CreateGroupRequest(val name: String, val description: String? = null)
data class Proxy(val id: Int = 0, val name: String? = null, val host: String? = null, val port: Int? = null, val protocol: String? = null)
data class CreateProxyRequest(val name: String, val host: String, val port: Int, val protocol: String? = null, val username: String? = null, val password: String? = null)
data class Extension(val id: Int = 0, val name: String = "", val description: String? = null, val version: String? = null)
