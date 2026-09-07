<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — Rust</h1>

<p align="center">
  Official Rust client for the Antybrowser Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.
</p>

<p align="center">
  <a href="https://crates.io/crates/antybrowser"><img src="https://img.shields.io/crates/v/antybrowser?color=CE412B&logo=rust&logoColor=white" alt="crates.io"></a>
  <a href="https://docs.rs/antybrowser"><img src="https://docs.rs/antybrowser/badge.svg" alt="docs.rs"></a>
  <a href="https://github.com/antybrowser/SDK"><img src="https://img.shields.io/github/stars/antybrowser/SDK?logo=github" alt="GitHub Stars"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>
</p>

---

## Installation

Add to your `Cargo.toml`:

```toml
[dependencies]
antybrowser = "1.0.2"
tokio = { version = "1", features = ["full"] }
```

## Quick Start

```rust
use antybrowser::AntybrowserClient;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let client = AntybrowserClient::new("your_api_key")
        .with_port(5173);

    // List profiles
    let profiles = client.get_profiles().await?;
    for p in &profiles {
        println!("{} (status: {:?})", p.name.as_deref().unwrap_or("unnamed"), p.status);
    }

    // Create a profile
    let profile = client.create_profile(antybrowser::CreateProfileRequest {
        name: "My Profile".to_string(),
        browser_type: Some("Chrome".to_string()),
        os_fingerprint: Some("Windows".to_string()),
        language: Some("en-US".to_string()),
        use_fingerprint: Some(true),
        ..Default::default()
    }).await?;

    // Start it
    let result = client.start_profile(profile.id).await?;
    println!("Debug port: {}", result.data.debug_port);

    Ok(())
}
```

## Configuration

```rust
// Default (port 5173)
let client = AntybrowserClient::new("my_key");

// Custom port
let client = AntybrowserClient::new("my_key").with_port(5174);

// Custom base URL
let client = AntybrowserClient::new("my_key")
    .with_base_url("http://10.0.0.5:5173");
```

## Error Handling

```rust
use antybrowser::AntybrowserError;

match client.get_profiles().await {
    Ok(profiles) => println!("Found {} profiles", profiles.len()),
    Err(AntybrowserError::Api { status, body }) => {
        eprintln!("API error {}: {}", status, body);
    }
    Err(e) => eprintln!("Error: {}", e),
}
```

## API Methods

| Method | Description |
|--------|-------------|
| `get_status()` | Check API connection |
| `get_settings()` | Get settings |
| `get_sync_status()` | Get sync status |
| `refresh_sync(profile_id)` | Trigger sync |
| `get_profiles()` | List profiles |
| `create_profile(request)` | Create profile |
| `update_profile(id, data)` | Update profile |
| `delete_profile(id)` | Delete profile |
| `start_profile(id)` | Start profile |
| `stop_profile(id)` | Stop profile |
| `duplicate_profile(id, name)` | Duplicate profile |
| `get_automations()` | List automations |
| `run_automation(id, profile_id)` | Run automation |
| `get_groups()` | List groups |
| `create_group(request)` | Create group |
| `update_group(id, data)` | Update group |
| `delete_group(id)` | Delete group |
| `get_proxies()` | List proxies |
| `create_proxy(request)` | Create proxy |
| `check_proxy(data)` | Check proxy |
| `delete_proxy(id)` | Delete proxy |
| `get_extensions()` | List extensions |
| `delete_extension(id)` | Delete extension |
| `get_profile_extensions(id)` | Get profile extensions |
| `set_profile_extensions(id, ids)` | Set profile extensions |

---

## Links

- [Antybrowser Website](https://antybrowser.com)
- [GitHub Repository](https://github.com/antybrowser/SDK)
- [crates.io Package](https://crates.io/crates/antybrowser)
- [docs.rs Documentation](https://docs.rs/antybrowser)
- [npm Package](https://www.npmjs.com/package/@antybrowser/sdk)
- [PyPI Package](https://pypi.org/project/antybrowser/)
- [NuGet Package](https://www.nuget.org/packages/Antybrowser.SDK/)
- [RubyGems Package](https://rubygems.org/gems/antybrowser)

## License

MIT
