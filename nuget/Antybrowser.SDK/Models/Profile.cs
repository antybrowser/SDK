using System.Text.Json.Serialization;

namespace Antybrowser.SDK.Models
{
    public class Profile
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("userId")]
        public int? UserId { get; set; }

        [JsonPropertyName("userGuid")]
        public string? UserGuid { get; set; }

        [JsonPropertyName("name")]
        public string? Name { get; set; }

        [JsonPropertyName("directoryName")]
        public string? DirectoryName { get; set; }

        [JsonPropertyName("groupId")]
        public int? GroupId { get; set; }

        [JsonPropertyName("proxyId")]
        public int? ProxyId { get; set; }

        [JsonPropertyName("browserType")]
        public string? BrowserType { get; set; }

        [JsonPropertyName("browserVersion")]
        public string? BrowserVersion { get; set; }

        [JsonPropertyName("osFingerprint")]
        public string? OsFingerprint { get; set; }

        [JsonPropertyName("screenResolution")]
        public string? ScreenResolution { get; set; }

        [JsonPropertyName("screenMaximizable")]
        public bool? ScreenMaximizable { get; set; }

        [JsonPropertyName("language")]
        public string? Language { get; set; }

        [JsonPropertyName("acceptLanguage")]
        public string? AcceptLanguage { get; set; }

        [JsonPropertyName("timezone")]
        public string? Timezone { get; set; }

        [JsonPropertyName("useFingerprint")]
        public bool? UseFingerprint { get; set; }

        /// <summary>Server-owned noise seed. Read-only — never sent on create/update.</summary>
        [JsonPropertyName("fingerprintId")]
        public string? FingerprintId { get; set; }

        [JsonPropertyName("platformVersion")]
        public string? PlatformVersion { get; set; }

        [JsonPropertyName("brandVersion")]
        public string? BrandVersion { get; set; }

        [JsonPropertyName("engineVersion")]
        public string? EngineVersion { get; set; }

        [JsonPropertyName("gpuVendor")]
        public string? GpuVendor { get; set; }

        [JsonPropertyName("gpuModel")]
        public string? GpuModel { get; set; }

        [JsonPropertyName("hardwareConcurrency")]
        public object? HardwareConcurrency { get; set; }

        [JsonPropertyName("deviceMemory")]
        public object? DeviceMemory { get; set; }

        [JsonPropertyName("deviceScaleFactor")]
        public object? DeviceScaleFactor { get; set; }

        [JsonPropertyName("mobileModel")]
        public string? MobileModel { get; set; }

        [JsonPropertyName("mobileVersion")]
        public object? MobileVersion { get; set; }

        [JsonPropertyName("chPlatform")]
        public string? ChPlatform { get; set; }

        [JsonPropertyName("chPlatformVersion")]
        public string? ChPlatformVersion { get; set; }

        [JsonPropertyName("chArch")]
        public string? ChArch { get; set; }

        [JsonPropertyName("chBitness")]
        public string? ChBitness { get; set; }

        [JsonPropertyName("chModel")]
        public string? ChModel { get; set; }

        [JsonPropertyName("chMobile")]
        public object? ChMobile { get; set; }

        [JsonPropertyName("disableSpoofing")]
        public string? DisableSpoofing { get; set; }

        [JsonPropertyName("locationMode")]
        public string? LocationMode { get; set; }

        [JsonPropertyName("locationLatitude")]
        public string? LocationLatitude { get; set; }

        [JsonPropertyName("locationLongitude")]
        public string? LocationLongitude { get; set; }

        [JsonPropertyName("locationAccuracy")]
        public string? LocationAccuracy { get; set; }

        [JsonPropertyName("userAgent")]
        public string? UserAgent { get; set; }

        [JsonPropertyName("restoreSession")]
        public bool? RestoreSession { get; set; }

        [JsonPropertyName("lowBandwidth")]
        public bool? LowBandwidth { get; set; }

        [JsonPropertyName("notes")]
        public string? Notes { get; set; }

        [JsonPropertyName("startUrl")]
        public string? StartUrl { get; set; }

        [JsonPropertyName("customFlags")]
        public string? CustomFlags { get; set; }

        [JsonPropertyName("status")]
        public string? Status { get; set; }

        [JsonPropertyName("statusMachineId")]
        public string? StatusMachineId { get; set; }

        [JsonPropertyName("statusHeartbeatAt")]
        public string? StatusHeartbeatAt { get; set; }

        [JsonPropertyName("needsSync")]
        public bool? NeedsSync { get; set; }

        [JsonPropertyName("lastPid")]
        public int? LastPid { get; set; }

        [JsonPropertyName("debugPort")]
        public int? DebugPort { get; set; }

        [JsonPropertyName("tabsSnapshot")]
        public string? TabsSnapshot { get; set; }

        [JsonPropertyName("createdAt")]
        public string? CreatedAt { get; set; }

        [JsonPropertyName("updatedAt")]
        public string? UpdatedAt { get; set; }
    }

    /// <summary>
    /// Payload for creating or updating a profile. Every property is optional except <see cref="Name"/>.
    /// <c>fingerprintId</c> is server-generated and <c>tlsGrease</c> is retired, so neither is sent.
    /// </summary>
    public class CreateProfileRequest
    {
        [JsonPropertyName("name")]
        public string? Name { get; set; }

        [JsonPropertyName("directoryName")]
        public string? DirectoryName { get; set; }

        [JsonPropertyName("groupId")]
        public int? GroupId { get; set; }

        [JsonPropertyName("proxyId")]
        public int? ProxyId { get; set; }

        /// <summary>Chrome, Edge, Opera, Vivaldi or Brave. Chromium is not a brand — it folds to Chrome.</summary>
        [JsonPropertyName("browserType")]
        public string? BrowserType { get; set; }

        [JsonPropertyName("browserVersion")]
        public string? BrowserVersion { get; set; }

        [JsonPropertyName("osFingerprint")]
        public string? OsFingerprint { get; set; }

        [JsonPropertyName("screenResolution")]
        public string? ScreenResolution { get; set; }

        [JsonPropertyName("screenMaximizable")]
        public bool? ScreenMaximizable { get; set; }

        [JsonPropertyName("language")]
        public string? Language { get; set; }

        [JsonPropertyName("acceptLanguage")]
        public string? AcceptLanguage { get; set; }

        [JsonPropertyName("timezone")]
        public string? Timezone { get; set; }

        [JsonPropertyName("useFingerprint")]
        public bool? UseFingerprint { get; set; }

        [JsonPropertyName("platformVersion")]
        public string? PlatformVersion { get; set; }

        [JsonPropertyName("brandVersion")]
        public string? BrandVersion { get; set; }

        [JsonPropertyName("engineVersion")]
        public string? EngineVersion { get; set; }

        [JsonPropertyName("gpuVendor")]
        public string? GpuVendor { get; set; }

        [JsonPropertyName("gpuModel")]
        public string? GpuModel { get; set; }

        [JsonPropertyName("hardwareConcurrency")]
        public object? HardwareConcurrency { get; set; }

        [JsonPropertyName("deviceMemory")]
        public object? DeviceMemory { get; set; }

        [JsonPropertyName("deviceScaleFactor")]
        public object? DeviceScaleFactor { get; set; }

        [JsonPropertyName("mobileModel")]
        public string? MobileModel { get; set; }

        [JsonPropertyName("mobileVersion")]
        public object? MobileVersion { get; set; }

        [JsonPropertyName("chPlatform")]
        public string? ChPlatform { get; set; }

        [JsonPropertyName("chPlatformVersion")]
        public string? ChPlatformVersion { get; set; }

        [JsonPropertyName("chArch")]
        public string? ChArch { get; set; }

        [JsonPropertyName("chBitness")]
        public string? ChBitness { get; set; }

        [JsonPropertyName("chModel")]
        public string? ChModel { get; set; }

        [JsonPropertyName("chMobile")]
        public object? ChMobile { get; set; }

        [JsonPropertyName("disableSpoofing")]
        public string? DisableSpoofing { get; set; }

        /// <summary>"" (off), "proxy" (based on the exit IP) or "manual".</summary>
        [JsonPropertyName("locationMode")]
        public string? LocationMode { get; set; }

        [JsonPropertyName("locationLatitude")]
        public string? LocationLatitude { get; set; }

        [JsonPropertyName("locationLongitude")]
        public string? LocationLongitude { get; set; }

        [JsonPropertyName("locationAccuracy")]
        public string? LocationAccuracy { get; set; }

        [JsonPropertyName("restoreSession")]
        public bool? RestoreSession { get; set; }

        [JsonPropertyName("lowBandwidth")]
        public bool? LowBandwidth { get; set; }

        [JsonPropertyName("notes")]
        public string? Notes { get; set; }

        [JsonPropertyName("startUrl")]
        public string? StartUrl { get; set; }

        [JsonPropertyName("customFlags")]
        public string? CustomFlags { get; set; }

        [JsonPropertyName("status")]
        public string? Status { get; set; }

        [JsonPropertyName("hidden")]
        public bool? Hidden { get; set; }
    }
}
