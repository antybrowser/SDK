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

## Prerequisites

- **Rust 2021+**
- **Antybrowser** desktop app running with the Local API enabled

## 🚀 Key Features

- **Profile Management**: Programmatically create, configure, start, and stop isolated browser profiles.
- **Fingerprint Control**: Manage canvas, WebGL, Audio, and other browser fingerprints to prevent detection.
- **Workflow Automation**: Execute complex browser automation scripts via our internal runner.
- **Proxy Management**: Seamlessly integrate HTTP, SOCKS4, and SOCKS5 proxies with bulk verification.
- **Multi-Accounting**: Scale your operations across hundreds of accounts with complete isolation.
- **Sync & Cloud**: Monitor profile synchronization status and cloud-based settings.

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

## API Reference

### System

| Method | Description |
|--------|-------------|
| `get_status()` | Check API connection status |
| `get_settings()` | Get current settings |
| `get_sync_status()` | Get sync queue status |
| `refresh_sync(profile_id)` | Trigger a sync refresh |

### Profiles

| Method | Description |
|--------|-------------|
| `get_profiles()` | List all profiles |
| `create_profile(request)` | Create a new profile |
| `update_profile(id, data)` | Update a profile |
| `delete_profile(id)` | Delete a profile |
| `start_profile(id)` | Start a profile (returns debug port) |
| `stop_profile(id)` | Stop a running profile |
| `duplicate_profile(id, name)` | Duplicate a profile |

### Automations

| Method | Description |
|--------|-------------|
| `get_automations()` | List all automations |
| `run_automation(id, profile_id)` | Run an automation on a profile |

### Groups

| Method | Description |
|--------|-------------|
| `get_groups()` | List all groups |
| `create_group(request)` | Create a group |
| `update_group(id, data)` | Update a group |
| `delete_group(id)` | Delete a group |

### Proxies

| Method | Description |
|--------|-------------|
| `get_proxies()` | List all proxies |
| `create_proxy(request)` | Add a proxy (validates connection) |
| `check_proxy(data)` | Check a single proxy |
| `check_proxies_bulk(proxies)` | Check multiple proxies |
| `delete_proxy(id)` | Delete a proxy |

### Extensions

| Method | Description |
|--------|-------------|
| `get_extensions()` | List all extensions |
| `delete_extension(id)` | Delete an extension |
| `get_profile_extensions(id)` | Get extensions for a profile |
| `set_profile_extensions(id, ids)` | Set extensions for a profile |

## Examples

### Create and launch a profile

```rust
let profile = client.create_profile(antybrowser::CreateProfileRequest {
    name: "My Profile".to_string(),
    browser_type: Some("Chrome".to_string()),
    os_fingerprint: Some("Windows".to_string()),
    language: Some("en-US".to_string()),
    use_fingerprint: Some(true),
    ..Default::default()
}).await?;

let result = client.start_profile(profile.id).await?;
println!("Debug port: {}", result.data.debug_port);
```

### Bulk proxy check

```rust
let results = client.check_proxies_bulk(vec![
    "user:pass:1.2.3.4:8080".to_string(),
    "5.6.7.8:3128:socks5".to_string(),
]).await?;

for (i, r) in results.iter().enumerate() {
    let label = if r.success {
        r.details.as_ref().map(|d| d.country.as_deref().unwrap_or("?")).unwrap_or("?")
    } else {
        r.error_message.as_deref().unwrap_or("unknown")
    };
    println!("Proxy {}: {}", i + 1, label);
}
```

### Run an automation

```rust
let result = client.run_automation(42, antybrowser::RunAutomationRequest {
    profile_id: 123,
    variables: Some(serde_json::json!({ "TARGET_URL": "https://example.com" })),
}).await?;

println!("{}", result.message); // "Automation completed"
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

## 🌐 Links

- [Antybrowser Website](https://antybrowser.com)
- [Documentation](https://docs.antybrowser.com)
- [GitHub Repository](https://github.com/antybrowser/SDK)
- [npm Package](https://www.npmjs.com/package/@antybrowser/sdk)
- [PyPI Package](https://pypi.org/project/antybrowser/)
- [Maven Central](https://central.sonatype.com/artifact/com.antybrowser/antybrowser-sdk)
- [NuGet Package](https://www.nuget.org/packages/Antybrowser.SDK/)
- [Go Module](https://github.com/antybrowser/SDK/tree/main/go)
- [crates.io](https://crates.io/crates/antybrowser)
- [RubyGems](https://rubygems.org/gems/antybrowser)
- [Packagist](https://packagist.org/packages/antybrowser/sdk)
- [Hex.pm](https://hex.pm/packages/antybrowser)
- [LuaRocks](https://luarocks.org/modules/antybrowser)
- [CPAN](https://metacpan.org/pod/Antybrowser::SDK)
- [pub.dev](https://pub.dev/packages/antybrowser)
- [Swift Package](https://github.com/antybrowser/SDK/tree/main/swift)
- [Julia Package](https://github.com/antybrowser/SDK/tree/main/julia)
- [R Package](https://cran.r-project.org/package=antybrowser)
- [Support](mailto:support@antybrowser.com)

## 📄 License

MIT

---
*Antybrowser - The ultimate solution for secure and undetectable multi-accounting.*
