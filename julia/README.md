<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — Julia</h1>

<p align="center">
  Official Julia client for the Antybrowser Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.
</p>

<p align="center">
  <a href="https://julialang.org/"><img src="https://img.shields.io/badge/Julia-1.6%2B-blue.svg" alt="Julia 1.6+"></a>
  <a href="https://github.com/antybrowser/SDK"><img src="https://img.shields.io/github/stars/antybrowser/SDK?style=social" alt="GitHub Stars"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="MIT License"></a>
</p>

---

## 📋 Prerequisites

- Julia 1.6+
- [Antybrowser](https://antybrowser.com) desktop app running on `http://127.0.0.1:5173`

## 🚀 Key Features

- **Profile Management**: Programmatically create, configure, start, and stop isolated browser profiles.
- **Fingerprint Control**: Manage canvas, WebGL, Audio, and other browser fingerprints to prevent detection.
- **Workflow Automation**: Execute complex browser automation scripts via our internal runner.
- **Proxy Management**: Seamlessly integrate HTTP, SOCKS4, and SOCKS5 proxies with bulk verification.
- **Multi-Accounting**: Scale your operations across hundreds of accounts with complete isolation.
- **Sync & Cloud**: Monitor profile synchronization status and cloud-based settings.

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/antybrowser/SDK", subdir="julia")
```

## Quick Start

```julia
using Antybrowser

# Create a client
client = AntybrowserClient("your-api-key")

# Get application status
status = get_status(client)

# List all profiles
profiles = get_profiles(client)

# Create a new profile
new_profile = create_profile(client, Dict(
    "name" => "My Profile",
    "groupId" => 1
))

# Start a profile
start_profile(client, new_profile["id"])

# Stop a profile
stop_profile(client, new_profile["id"])

# Duplicate a profile
dup = duplicate_profile(client, new_profile["id"], name="My Profile Copy")

# Delete a profile
delete_profile(client, new_profile["id"])
```

## API Reference

### System

| Function | Description |
|---|---|
| `get_status(client)` | Get application status |
| `get_settings(client)` | Get application settings |
| `get_sync_status(client)` | Get sync status |
| `refresh_sync(client, profile_id)` | Trigger sync refresh |

### Profiles

| Function | Description |
|---|---|
| `get_profiles(client)` | List all profiles |
| `create_profile(client, data)` | Create a new profile |
| `update_profile(client, id, data)` | Update a profile |
| `delete_profile(client, id)` | Delete a profile |
| `start_profile(client, id)` | Start a profile |
| `stop_profile(client, id)` | Stop a profile |
| `duplicate_profile(client, id, name)` | Duplicate a profile |

### Automations

| Function | Description |
|---|---|
| `get_automations(client)` | List all automations |
| `run_automation(client, id, profile_id)` | Run an automation |

### Groups

| Function | Description |
|---|---|
| `get_groups(client)` | List all groups |
| `create_group(client, data)` | Create a new group |
| `update_group(client, id, data)` | Update a group |
| `delete_group(client, id)` | Delete a group |

### Proxies

| Function | Description |
|---|---|
| `get_proxies(client)` | List all proxies |
| `create_proxy(client, data)` | Create a new proxy |
| `check_proxy(client, data)` | Check proxy connectivity |
| `delete_proxy(client, id)` | Delete a proxy |

### Extensions

| Function | Description |
|---|---|
| `get_extensions(client)` | List all extensions |
| `delete_extension(client, id)` | Delete an extension |
| `get_profile_extensions(client, profile_id)` | List profile extensions |
| `set_profile_extensions(client, profile_id, extension_ids)` | Set profile extensions |

## Examples

### Create and launch a profile

```julia
using Antybrowser

client = AntybrowserClient("your-api-key")

profile = create_profile(client, Dict("name" => "My Profile"))
result = start_profile(client, profile["id"])
println("Profile started with debug port: $(result["data"]["debugPort"])")
```

### Bulk proxy check

```julia
using Antybrowser

client = AntybrowserClient("your-api-key")

proxies = get_proxies(client)
for proxy in proxies
    check = check_proxy(client, Dict(
        "host" => proxy["host"],
        "port" => proxy["port"],
        "username" => proxy["username"],
        "password" => proxy["password"]
    ))
    println("$(proxy["name"]): $(check["data"]["status"])")
end
```

### Run an automation

```julia
using Antybrowser

client = AntybrowserClient("your-api-key")

automations = get_automations(client)
result = run_automation(client, automations[1]["id"], 1)
println("Automation started: $result")
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

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---
*Antybrowser - The ultimate solution for secure and undetectable multi-accounting.*
