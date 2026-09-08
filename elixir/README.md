<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — Elixir</h1>

<p align="center">Official Elixir client for the Antybrowser Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.</p>

<p align="center">
  <a href="https://hex.pm/packages/antybrowser"><img src="https://img.shields.io/hexpm/v/antybrowser" alt="Hex.pm"></a>
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

- **Elixir ~> 1.14**
- **Antybrowser** desktop application installed and running with the Local API enabled

## 📦 Installation

### Hex

```elixir
# mix.exs
def deps do
  [{:antybrowser, "~> 1.0"}]
end
```

```sh
mix deps.get
```

## 🛠 Usage

```elixir
client = Antybrowser.new("your_api_key")

# List profiles
{:ok, profiles} = Antybrowser.get_profiles(client)

# Create a profile
{:ok, profile} = Antybrowser.create_profile(client, %{name: "My Profile"})

# Start a profile
{:ok, result} = Antybrowser.start_profile(client, profile["id"])

# Stop a profile
{:ok, _} = Antybrowser.stop_profile(client, profile["id"])

# Delete a profile
{:ok, _} = Antybrowser.delete_profile(client, profile["id"])
```

## 📚 API Reference

### Constructor

```elixir
Antybrowser.new(api_key, opts \\ [])
```

- `api_key` — your Antybrowser API key
- `opts` — keyword list:
  - `:port` — API port (default: `5173`)

### System
| Function | Description |
|----------|-------------|
| `get_status/1` | Check API connection status |
| `get_settings/1` | Get current application settings |
| `get_sync_status/1` | Get sync queue status |
| `refresh_sync/2` | Trigger a sync refresh (optional `profile_id`) |

### Profiles
| Function | Description |
|----------|-------------|
| `get_profiles/1` | List all profiles |
| `create_profile/2` | Create a new profile |
| `update_profile/3` | Update a profile |
| `delete_profile/2` | Delete a profile |
| `start_profile/2` | Start a profile browser |
| `stop_profile/2` | Stop a profile browser |
| `duplicate_profile/3` | Duplicate a profile (optional `name`) |

### Automations
| Function | Description |
|----------|-------------|
| `get_automations/1` | List automations |
| `run_automation/3` | Run an automation on a profile |

### Groups
| Function | Description |
|----------|-------------|
| `get_groups/1` | List groups |
| `create_group/2` | Create a group |
| `update_group/3` | Update a group |
| `delete_group/2` | Delete a group |

### Proxies
| Function | Description |
|----------|-------------|
| `get_proxies/1` | List proxies |
| `create_proxy/2` | Create a proxy |
| `check_proxy/2` | Check proxy connectivity |
| `delete_proxy/2` | Delete a proxy |

### Extensions
| Function | Description |
|----------|-------------|
| `get_extensions/1` | List extensions |
| `delete_extension/2` | Delete an extension |
| `get_profile_extensions/2` | List profile extensions |
| `set_profile_extensions/3` | Set profile extensions |

## 💡 Examples

### Create and Launch a Profile

```elixir
client = Antybrowser.new("your_api_key")

{:ok, profile} = Antybrowser.create_profile(client, %{
  name: "My Profile",
  proxy: "socks5://user:pass@host:port"
})

{:ok, result} = Antybrowser.start_profile(client, profile["id"])
IO.puts("Debug port: #{result["data"]["debugPort"]}")
```

### Bulk Proxy Check

```elixir
proxies = [
  %{host: "1.2.3.4", port: 8080, type: "socks5"},
  %{host: "5.6.7.8", port: 1080, type: "socks5"}
]

{:ok, results} = Antybrowser.check_proxies_bulk(client, proxies)
Enum.each(results, fn r ->
  IO.puts("#{r["host"]}:#{r["port"]} — #{if r["alive"], do: "OK", else: "Failed"}")
end)
```

### Run an Automation

```elixir
{:ok, result} = Antybrowser.run_automation(client, 42, %{
  "profileId" => profile["id"],
  "variables" => %{"target_url" => "https://example.com"}
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