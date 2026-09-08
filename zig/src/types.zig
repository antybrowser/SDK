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

pub const ProxyCheckResult = struct {
    alive: ?bool = null,
    ip: ?[]const u8 = null,
    port: ?u16 = null,
    country: ?[]const u8 = null,
    city: ?[]const u8 = null,
    isp: ?[]const u8 = null,
    protocol: ?[]const u8 = null,
    latency_ms: ?u64 = null,
};

pub const Profile = struct {
    id: ?[]const u8 = null,
    name: ?[]const u8 = null,
    group_id: ?[]const u8 = null,
    proxy_id: ?[]const u8 = null,
    os: ?[]const u8 = null,
    browser: ?[]const u8 = null,
    user_agent: ?[]const u8 = null,
    screen_resolution: ?[]const u8 = null,
    language: ?[]const u8 = null,
    timezone: ?[]const u8 = null,
    geoip: ?[]const u8 = null,
    webrtc: ?[]const u8 = null,
    canvas: ?[]const u8 = null,
    webgl: ?[]const u8 = null,
    audio: ?[]const u8 = null,
    fonts: ?[]const []const u8 = null,
    plugins: ?[]const []const u8 = null,
    extensions: ?[]const []const u8 = null,
    notes: ?[]const u8 = null,
    created_at: ?[]const u8 = null,
    updated_at: ?[]const u8 = null,
};

pub const CreateProfileRequest = struct {
    name: []const u8,
    group_id: ?[]const u8 = null,
    proxy_id: ?[]const u8 = null,
    os: ?[]const u8 = null,
    browser: ?[]const u8 = null,
    user_agent: ?[]const u8 = null,
    screen_resolution: ?[]const u8 = null,
    language: ?[]const u8 = null,
    timezone: ?[]const u8 = null,
    geoip: ?[]const u8 = null,
    webrtc: ?[]const u8 = null,
    canvas: ?[]const u8 = null,
    webgl: ?[]const u8 = null,
    audio: ?[]const u8 = null,
    fonts: ?[]const []const u8 = null,
    plugins: ?[]const []const u8 = null,
    extensions: ?[]const []const u8 = null,
    notes: ?[]const u8 = null,
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

pub const Settings = struct {
    default_os: ?[]const u8 = null,
    default_browser: ?[]const u8 = null,
    default_screen_resolution: ?[]const u8 = null,
    default_language: ?[]const u8 = null,
    default_timezone: ?[]const u8 = null,
    auto_update: ?bool = null,
    notifications: ?bool = null,
    theme: ?[]const u8 = null,
    proxy_check_on_create: ?bool = null,
    launch_timeout_ms: ?u64 = null,
};

pub const SyncStatus = struct {
    syncing: ?bool = null,
    last_sync: ?[]const u8 = null,
    profiles_synced: ?u32 = null,
    proxies_synced: ?u32 = null,
    groups_synced: ?u32 = null,
};

pub const StatusResponse = struct {
    version: ?[]const u8 = null,
    running: ?bool = null,
    profiles_count: ?u32 = null,
    proxies_count: ?u32 = null,
    groups_count: ?u32 = null,
    uptime_seconds: ?u64 = null,
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
