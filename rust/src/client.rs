use crate::errors::AntybrowserError;
use crate::models::*;
use reqwest::Client;

pub struct AntybrowserClient {
    api_key: String,
    base_url: String,
    http: Client,
}

impl AntybrowserClient {
    pub fn new(api_key: impl Into<String>) -> Self {
        Self {
            api_key: api_key.into(),
            base_url: "http://127.0.0.1:5173".to_string(),
            http: Client::new(),
        }
    }

    pub fn with_port(mut self, port: u16) -> Self {
        self.base_url = format!("http://127.0.0.1:{}", port);
        self
    }

    pub fn with_base_url(mut self, url: impl Into<String>) -> Self {
        self.base_url = url.into();
        self
    }

    // System

    pub async fn get_status(&self) -> Result<ApiResponse, AntybrowserError> {
        self.get("/api/status").await
    }

    pub async fn get_settings(&self) -> Result<Settings, AntybrowserError> {
        self.get("/api/settings").await
    }

    pub async fn get_sync_status(&self) -> Result<SyncStatus, AntybrowserError> {
        self.get("/api/sync/status").await
    }

    pub async fn refresh_sync(&self, profile_id: Option<i64>) -> Result<ApiResponse, AntybrowserError> {
        let body = if let Some(id) = profile_id {
            serde_json::json!({ "profileId": id })
        } else {
            serde_json::json!({})
        };
        self.post("/api/sync/refresh", Some(body)).await
    }

    // Profiles

    pub async fn get_profiles(&self) -> Result<Vec<Profile>, AntybrowserError> {
        self.get("/api/profiles").await
    }

    pub async fn create_profile(&self, request: CreateProfileRequest) -> Result<Profile, AntybrowserError> {
        self.post("/api/profiles", Some(serde_json::to_value(request)?)).await
    }

    pub async fn update_profile(&self, id: i64, data: serde_json::Value) -> Result<Profile, AntybrowserError> {
        self.put(&format!("/api/profiles/{}", id), data).await
    }

    pub async fn delete_profile(&self, id: i64) -> Result<ApiResponse, AntybrowserError> {
        self.delete(&format!("/api/profiles/{}", id)).await
    }

    pub async fn start_profile(&self, id: i64) -> Result<StartProfileResponse, AntybrowserError> {
        self.post(&format!("/api/profiles/{}/start", id), None).await
    }

    pub async fn stop_profile(&self, id: i64) -> Result<ApiResponse, AntybrowserError> {
        self.post(&format!("/api/profiles/{}/stop", id), None).await
    }

    pub async fn duplicate_profile(&self, id: i64, name: Option<&str>) -> Result<Profile, AntybrowserError> {
        let body = name.map(|n| serde_json::json!({ "name": n }));
        self.post(&format!("/api/profiles/{}/duplicate", id), body).await
    }

    // Automations

    pub async fn get_automations(&self) -> Result<Vec<Automation>, AntybrowserError> {
        self.get("/api/automations").await
    }

    pub async fn run_automation(&self, id: i64, profile_id: i64) -> Result<RunAutomationResult, AntybrowserError> {
        self.post(&format!("/api/automations/{}/run", id), Some(serde_json::json!({ "profileId": profile_id }))).await
    }

    // Groups

    pub async fn get_groups(&self) -> Result<Vec<Group>, AntybrowserError> {
        self.get("/api/groups").await
    }

    pub async fn create_group(&self, request: CreateGroupRequest) -> Result<Group, AntybrowserError> {
        self.post("/api/groups", Some(serde_json::to_value(request)?)).await
    }

    pub async fn update_group(&self, id: i64, data: serde_json::Value) -> Result<Group, AntybrowserError> {
        self.put(&format!("/api/groups/{}", id), data).await
    }

    pub async fn delete_group(&self, id: i64) -> Result<ApiResponse, AntybrowserError> {
        self.delete(&format!("/api/groups/{}", id)).await
    }

    // Proxies

    pub async fn get_proxies(&self) -> Result<Vec<Proxy>, AntybrowserError> {
        self.get("/api/proxies").await
    }

    pub async fn create_proxy(&self, request: CreateProxyRequest) -> Result<Proxy, AntybrowserError> {
        self.post("/api/proxies", Some(serde_json::to_value(request)?)).await
    }

    pub async fn check_proxy(&self, data: serde_json::Value) -> Result<ProxyCheckResult, AntybrowserError> {
        self.post("/api/proxies/check", Some(data)).await
    }

    pub async fn delete_proxy(&self, id: i64) -> Result<ApiResponse, AntybrowserError> {
        self.delete(&format!("/api/proxies/{}", id)).await
    }

    // Extensions

    pub async fn get_extensions(&self) -> Result<Vec<Extension>, AntybrowserError> {
        self.get("/api/extensions").await
    }

    pub async fn delete_extension(&self, id: i64) -> Result<ApiResponse, AntybrowserError> {
        self.delete(&format!("/api/extensions/{}", id)).await
    }

    pub async fn get_profile_extensions(&self, profile_id: i64) -> Result<Vec<Extension>, AntybrowserError> {
        self.get(&format!("/api/profiles/{}/extensions", profile_id)).await
    }

    pub async fn set_profile_extensions(&self, profile_id: i64, extension_ids: Vec<i64>) -> Result<ApiResponse, AntybrowserError> {
        self.post(&format!("/api/profiles/{}/extensions", profile_id), Some(serde_json::json!({ "extensionIds": extension_ids }))).await
    }

    // HTTP helpers

    async fn get<T: serde::de::DeserializeOwned>(&self, path: &str) -> Result<T, AntybrowserError> {
        let resp = self.http
            .get(format!("{}{}", self.base_url, path))
            .header("x-api-key", &self.api_key)
            .send()
            .await?;
        self.handle_response(resp).await
    }

    async fn post<T: serde::de::DeserializeOwned>(&self, path: &str, body: Option<serde_json::Value>) -> Result<T, AntybrowserError> {
        let mut req = self.http
            .post(format!("{}{}", self.base_url, path))
            .header("x-api-key", &self.api_key);
        if let Some(b) = body {
            req = req.json(&b);
        }
        let resp = req.send().await?;
        self.handle_response(resp).await
    }

    async fn put<T: serde::de::DeserializeOwned>(&self, path: &str, body: serde_json::Value) -> Result<T, AntybrowserError> {
        let resp = self.http
            .put(format!("{}{}", self.base_url, path))
            .header("x-api-key", &self.api_key)
            .json(&body)
            .send()
            .await?;
        self.handle_response(resp).await
    }

    async fn delete<T: serde::de::DeserializeOwned>(&self, path: &str) -> Result<T, AntybrowserError> {
        let resp = self.http
            .delete(format!("{}{}", self.base_url, path))
            .header("x-api-key", &self.api_key)
            .send()
            .await?;
        self.handle_response(resp).await
    }

    async fn handle_response<T: serde::de::DeserializeOwned>(&self, resp: reqwest::Response) -> Result<T, AntybrowserError> {
        let status = resp.status();
        let text = resp.text().await?;
        if !status.is_success() {
            return Err(AntybrowserError::Api {
                status: status.as_u16(),
                body: text,
            });
        }
        Ok(serde_json::from_str(&text)?)
    }
}
