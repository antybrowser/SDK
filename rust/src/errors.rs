use thiserror::Error;

#[derive(Error, Debug)]
pub enum AntybrowserError {
    #[error("API request failed with status {status}: {body}")]
    Api { status: u16, body: String },

    #[error("HTTP error: {0}")]
    Http(#[from] reqwest::Error),

    #[error("JSON error: {0}")]
    Json(#[from] serde_json::Error),
}
