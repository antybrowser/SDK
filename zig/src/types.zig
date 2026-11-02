const std = @import("std");

pub const Proxy = struct {
    id: ?[]const u8 = null,
    name: ?[]const u8 = null,
    host: ?[]const u8 = null,
    port: ?u16 = null,
    username: ?[]const u8 = null,
    password: ?[]const u8 = null,
    proxy_type: ?[]const u8 = null,
    country: ?[]const u8 = null,
    city: ?[]const u8 = null,
    isp: ?[]const u8 = null,
    rotation: ?[]const u8 = null,
};

pub const CreateProxyRequest = struct {
    name: ?[]const u8 = null,
    host: []const u8,
    port: u16,
    username: ?[]const u8 = null,
    password: ?[]const u8 = null,
    proxy_type: ?[]const u8 = null,
    country: ?[]const u8 = null,
    city: ?[]const u8 = null,
    isp: ?[]const u8 = null,
    rotation: ?[]const u8 = null,
};

pub const Profile = struct {
    id: ?[]const u8 = null,
    user_id: ?[]const u8 = null,
    user_guid: ?[]const u8 = null,
    name: ?[]const u8 = null,
    directory_name: ?[]const u8 = null,
    group_id: ?[]const u8 = null,
    proxy_id: ?[]const u8 = null,
    browser_type: ?[]const u8 = null,
    browser_version: ?[]const u8 = null,
    os_fingerprint: ?[]const u8 = null,
    screen_resolution: ?[]const u8 = null,
    screen_maximizable: ?bool = null,
    language: ?[]const u8 = null,
    accept_language: ?[]const u8 = null,
    timezone: ?[]const u8 = null,
    use_fingerprint: ?bool = null,
    /// Server-owned noise seed. Read-only — never sent on create/update.
    fingerprint_id: ?[]const u8 = null,
    // --- Fingerprint surface ---
    platform_version: ?[]const u8 = null,
    brand_version: ?[]const u8 = null,
    engine_version: ?[]const u8 = null,
    gpu_vendor: ?[]const u8 = null,
    gpu_model: ?[]const u8 = null,
    hardware_concurrency: ?std.json.Value = null,
    device_memory: ?std.json.Value = null,
    device_scale_factor: ?std.json.Value = null,
    mobile_model: ?[]const u8 = null,
    mobile_version: ?std.json.Value = null,
    ch_platform: ?[]const u8 = null,
    ch_platform_version: ?[]const u8 = null,
    ch_arch: ?[]const u8 = null,
    ch_bitness: ?[]const u8 = null,
    ch_model: ?[]const u8 = null,
    ch_mobile: ?std.json.Value = null,
    disable_spoofing: ?[]const u8 = null,
    // --- Geolocation spoof ---
    location_mode: ?[]const u8 = null,
    location_latitude: ?[]const u8 = null,
    location_longitude: ?[]const u8 = null,
    location_accuracy: ?[]const u8 = null,
    user_agent: ?[]const u8 = null,
    restore_session: ?bool = null,
    low_bandwidth: ?bool = null,
    notes: ?[]const u8 = null,
    start_url: ?[]const u8 = null,
    custom_flags: ?[]const u8 = null,
    status: ?[]const u8 = null,
    status_machine_id: ?[]const u8 = null,
    status_heartbeat_at: ?[]const u8 = null,
    needs_sync: ?bool = null,
    last_pid: ?u32 = null,
    debug_port: ?u32 = null,
    tabs_snapshot: ?[]const u8 = null,
    hidden: ?bool = null,
    trash: ?bool = null,
    deleted_at: ?[]const u8 = null,
    created_at: ?[]const u8 = null,
    updated_at: ?[]const u8 = null,
    last_synced_at: ?[]const u8 = null,
    s3_key: ?[]const u8 = null,
    os: ?[]const u8 = null,
    browser: ?[]const u8 = null,
    geoip: ?[]const u8 = null,
    webrtc: ?[]const u8 = null,
    canvas: ?[]const u8 = null,
    webgl: ?[]const u8 = null,
    audio: ?[]const u8 = null,
    fonts: ?[]const []const u8 = null,
    plugins: ?[]const []const u8 = null,
    extensions: ?[]const []const u8 = null,
};

pub const CreateProfileRequest = struct {
    name: []const u8,
    directory_name: ?[]const u8 = null,
    group_id: ?[]const u8 = null,
    proxy_id: ?[]const u8 = null,
    browser_type: ?[]const u8 = null,
    browser_version: ?[]const u8 = null,
    os_fingerprint: ?[]const u8 = null,
    screen_resolution: ?[]const u8 = null,
    screen_maximizable: ?bool = null,
    language: ?[]const u8 = null,
    accept_language: ?[]const u8 = null,
    timezone: ?[]const u8 = null,
    use_fingerprint: ?bool = null,
    platform_version: ?[]const u8 = null,
    brand_version: ?[]const u8 = null,
    engine_version: ?[]const u8 = null,
    gpu_vendor: ?[]const u8 = null,
    gpu_model: ?[]const u8 = null,
    hardware_concurrency: ?std.json.Value = null,
    device_memory: ?std.json.Value = null,
    device_scale_factor: ?std.json.Value = null,
    mobile_model: ?[]const u8 = null,
    mobile_version: ?std.json.Value = null,
    ch_platform: ?[]const u8 = null,
    ch_platform_version: ?[]const u8 = null,
    ch_arch: ?[]const u8 = null,
    ch_bitness: ?[]const u8 = null,
    ch_model: ?[]const u8 = null,
    ch_mobile: ?std.json.Value = null,
    disable_spoofing: ?[]const u8 = null,
    location_mode: ?[]const u8 = null,
    location_latitude: ?[]const u8 = null,
    location_longitude: ?[]const u8 = null,
    location_accuracy: ?[]const u8 = null,
    restore_session: ?bool = null,
    low_bandwidth: ?bool = null,
    notes: ?[]const u8 = null,
    start_url: ?[]const u8 = null,
    custom_flags: ?[]const u8 = null,
    status: ?[]const u8 = null,
    hidden: ?bool = null,
    os: ?[]const u8 = null,
    browser: ?[]const u8 = null,
    user_agent: ?[]const u8 = null,
    geoip: ?[]const u8 = null,
    webrtc: ?[]const u8 = null,
    canvas: ?[]const u8 = null,
    webgl: ?[]const u8 = null,
    audio: ?[]const u8 = null,
    fonts: ?[]const []const u8 = null,
    plugins: ?[]const []const u8 = null,
    extensions: ?[]const []const u8 = null,
};

pub const DuplicateProfileRequest = struct {
    name: ?[]const u8 = null,
    copy_proxy: ?bool = null,
    copy_cookies: ?bool = null,
    copy_extensions: ?bool = null,
};

pub const Group = struct {
    id: ?[]const u8 = null,
    name: ?[]const u8 = null,
    description: ?[]const u8 = null,
    profile_count: ?u32 = null,
    created_at: ?[]const u8 = null,
    updated_at: ?[]const u8 = null,
};

pub const CreateGroupRequest = struct {
    name: []const u8,
    description: ?[]const u8 = null,
};

pub const Extension = struct {
    id: ?[]const u8 = null,
    name: ?[]const u8 = null,
    description: ?[]const u8 = null,
    version: ?[]const u8 = null,
    enabled: ?bool = null,
    path: ?[]const u8 = null,
};

pub const Automation = struct {
    id: ?[]const u8 = null,
    name: ?[]const u8 = null,
    profile_id: ?[]const u8 = null,
    status: ?[]const u8 = null,
    script: ?[]const u8 = null,
    created_at: ?[]const u8 = null,
    updated_at: ?[]const u8 = null,
};

pub const RunAutomationRequest = struct {
    profile_id: []const u8,
    script: ?[]const u8 = null,
    url: ?[]const u8 = null,
    actions: ?[]const AutomationAction = null,
};

pub const AutomationAction = struct {
    action: []const u8,
    selector: ?[]const u8 = null,
    value: ?[]const u8 = null,
    timeout_ms: ?u64 = null,
};

pub const RunAutomationResult = struct {
    id: ?[]const u8 = null,
    status: ?[]const u8 = null,
    started_at: ?[]const u8 = null,
};

pub const StartProfileResponse = struct {
    profile_id: ?[]const u8 = null,
    port: ?u16 = null,
    ws_url: ?[]const u8 = null,
    webdriver_url: ?[]const u8 = null,
    started_at: ?[]const u8 = null,
};

pub const ApiResponse = struct {
    success: bool,
    data: ?[]const u8 = null,
    error: ?[]const u8 = null,
    message: ?[]const u8 = null,
};

pub const ProfileListResponse = struct {
    success: bool,
    data: ?[]Profile = null,
    total: ?u32 = null,
};

pub const ProxyListResponse = struct {
    success: bool,
    data: ?[]Proxy = null,
    total: ?u32 = null,
};

pub const GroupListResponse = struct {
    success: bool,
    data: ?[]Group = null,
    total: ?u32 = null,
};

pub const ExtensionListResponse = struct {
    success: bool,
    data: ?[]Extension = null,
    total: ?u32 = null,
};
