use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ApiResponse {
    pub success: bool,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub message: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub data: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Profile {
    pub id: i64,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub user_id: Option<i64>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub user_guid: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub name: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub directory_name: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub group_id: Option<i64>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub proxy_id: Option<i64>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub browser_type: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub browser_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub os_fingerprint: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub screen_resolution: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub screen_maximizable: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub language: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub accept_language: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub timezone: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub use_fingerprint: Option<bool>,
    /// Server-owned noise seed. Read-only — never sent on create/update.
    #[serde(skip_serializing_if = "Option::is_none")]
    pub fingerprint_id: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub platform_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub brand_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub engine_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub gpu_vendor: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub gpu_model: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub hardware_concurrency: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub device_memory: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub device_scale_factor: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub mobile_model: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub mobile_version: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_platform: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_platform_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_arch: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_bitness: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_model: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_mobile: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub disable_spoofing: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub location_mode: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub location_latitude: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub location_longitude: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub location_accuracy: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub user_agent: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub restore_session: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub low_bandwidth: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub notes: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub start_url: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub custom_flags: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub status: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub status_machine_id: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub status_heartbeat_at: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub needs_sync: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub last_pid: Option<i64>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub debug_port: Option<i64>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub tabs_snapshot: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub hidden: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub trash: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub deleted_at: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub created_at: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub updated_at: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub last_synced_at: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub s3_key: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CreateProfileRequest {
    pub name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub directory_name: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub group_id: Option<i64>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub proxy_id: Option<i64>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub browser_type: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub browser_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub os_fingerprint: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub screen_resolution: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub screen_maximizable: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub language: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub accept_language: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub timezone: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub use_fingerprint: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub platform_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub brand_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub engine_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub gpu_vendor: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub gpu_model: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub hardware_concurrency: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub device_memory: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub device_scale_factor: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub mobile_model: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub mobile_version: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_platform: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_platform_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_arch: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_bitness: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_model: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_mobile: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub disable_spoofing: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub location_mode: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub location_latitude: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub location_longitude: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub location_accuracy: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub restore_session: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub low_bandwidth: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub notes: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub start_url: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub custom_flags: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub status: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub hidden: Option<bool>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UpdateProfileRequest {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub name: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub directory_name: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub group_id: Option<i64>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub proxy_id: Option<i64>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub browser_type: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub browser_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub os_fingerprint: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub screen_resolution: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub screen_maximizable: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub language: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub accept_language: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub timezone: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub use_fingerprint: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub platform_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub brand_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub engine_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub gpu_vendor: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub gpu_model: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub hardware_concurrency: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub device_memory: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub device_scale_factor: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub mobile_model: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub mobile_version: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_platform: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_platform_version: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_arch: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_bitness: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_model: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub ch_mobile: Option<serde_json::Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub disable_spoofing: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub location_mode: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub location_latitude: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub location_longitude: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub location_accuracy: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub restore_session: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub low_bandwidth: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub notes: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub start_url: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub custom_flags: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub status: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub hidden: Option<bool>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StartProfileResponse {
    pub success: bool,
    pub data: StartProfileData,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StartProfileData {
    pub debug_port: u16,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Automation {
    pub id: i64,
    pub name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub description: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub status: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub created_at: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RunAutomationResult {
    pub success: bool,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub message: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Group {
    pub id: i64,
    pub name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub description: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub color: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CreateGroupRequest {
    pub name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub description: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Proxy {
    pub id: i64,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub name: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub host: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub port: Option<u16>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub protocol: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CreateProxyRequest {
    pub name: String,
    pub host: String,
    pub port: u16,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub protocol: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub username: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub password: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Extension {
    pub id: i64,
    pub name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub description: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub version: Option<String>,
}
