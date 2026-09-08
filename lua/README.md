<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — Lua</h1>

<p align="center">Official Lua client for the Antybrowser Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.</p>

<p align="center">
  <a href="https://luarocks.org/modules/antybrowser"><img src="https://img.shields.io/badge/LuaRocks-antybrowser-blue" alt="LuaRocks"></a>
  <a href="https://github.com/antybrowser/SDK"><img src="https://img.shields.io/github/stars/antybrowser/SDK" alt="GitHub Stars"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>
</p>

## 🚀 Key Features

- **Profile Management**: Programmatically create, configure, start, and stop isolated browser profiles.
- **Fingerprint Control**: Manage canvas, WebGL, Audio, and other browser fingerprints to prevent detection.
- **Workflow Automation**: Execute complex browser automation scripts via our internal runner.
- **Proxy Management**: Seamlessly integrate HTTP, SOCKS4, and SOCKS5 proxies with bulk verification.
- **Multi-Accounting**: Scale your operations across hundreds of accounts with complete isolation.
- **Sync & Cloud**: Monitor profile synchronization status and cloud-based settings.

## 📋 Prerequisites

- **Lua >= 5.1**
- **Antybrowser** desktop application installed and running with the Local API enabled

## 📦 Installation

### LuaRocks

```sh
luarocks install antybrowser
```

## 🛠 Usage

```lua
local antybrowser = require("antybrowser")

local client = antybrowser.new("your_api_key")

-- List profiles
local profiles = client:get_profiles()

-- Create a profile
local profile = client:create_profile({ name = "My Profile" })

-- Start a profile
local result = client:start_profile(profile.id)

-- Stop a profile
client:stop_profile(profile.id)

-- Delete a profile
client:delete_profile(profile.id)
```

## 📚 API Reference

### Constructor

```lua
antybrowser.new(api_key, opts)
```

- `api_key` — your Antybrowser API key
- `opts` — optional table:
  - `port` — API port (default: `5173`)
  - `base_url` — override full base URL

### System
| Method | Description |
|--------|-------------|
| `:get_status()` | Check API connection status |
| `:get_settings()` | Get current application settings |
| `:get_sync_status()` | Get sync queue status |
| `:refresh_sync(profile_id?)` | Trigger a sync refresh |

### Profiles
| Method | Description |
|--------|-------------|
| `:get_profiles()` | List all profiles |
| `:create_profile(data)` | Create a new profile |
| `:update_profile(id, data)` | Update a profile |
| `:delete_profile(id)` | Delete a profile |
| `:start_profile(id)` | Start a profile browser |
| `:stop_profile(id)` | Stop a profile browser |
| `:duplicate_profile(id, name?)` | Duplicate a profile |

### Automations
| Method | Description |
|--------|-------------|
| `:get_automations()` | List all automations |
| `:run_automation(id, profile_id)` | Run an automation on a profile |

### Groups
| Method | Description |
|--------|-------------|
| `:get_groups()` | List all groups |
| `:create_group(data)` | Create a group |
| `:update_group(id, data)` | Update a group |
| `:delete_group(id)` | Delete a group |

### Proxies
| Method | Description |
|--------|-------------|
| `:get_proxies()` | List all proxies |
| `:create_proxy(data)` | Add a proxy (validates connection) |
| `:check_proxy(data)` | Check proxy connectivity |
| `:delete_proxy(id)` | Delete a proxy |

### Extensions
| Method | Description |
|--------|-------------|
| `:get_extensions()` | List all extensions |
| `:delete_extension(id)` | Delete an extension |
| `:get_profile_extensions(profile_id)` | List profile extensions |
| `:set_profile_extensions(profile_id, extension_ids)` | Set profile extensions |

## 💡 Examples

### Create and Launch a Profile

```lua
local antybrowser = require("antybrowser")
local client = antybrowser.new("your_api_key")

local profile = client:create_profile({
    name = "My Profile",
    proxy = "socks5://user:pass@host:port"
})

local result = client:start_profile(profile.id)
print("Debug port: " .. result.data.debugPort)
```

### Bulk Proxy Check

```lua
local proxies = {
    { host = "1.2.3.4", port = 8080, type = "socks5" },
    { host = "5.6.7.8", port = 1080, type = "socks5" }
}

local results = client:check_proxies_bulk(proxies)
for _, r in ipairs(results) do
    local status = r.alive and "OK" or "Failed"
    print(r.host .. ":" .. r.port .. " — " .. status)
end
```

### Run an Automation

```lua
local result = client:run_automation(42, {
    profileId = profile.id,
    variables = { target_url = "https://example.com" }
})
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