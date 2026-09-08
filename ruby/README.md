<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — Ruby</h1>

<p align="center">
  Official Ruby client for the Antybrowser Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.
</p>

<p align="center">
  <a href="https://rubygems.org/gems/antybrowser"><img src="https://img.shields.io/gem/v/antybrowser?color=CC342D&logo=rubygems&logoColor=white" alt="Gem Version"></a>
  <a href="https://rubygems.org/gems/antybrowser"><img src="https://img.shields.io/badge/ruby-%3E%3D3.0-CC342D?logo=ruby&logoColor=white" alt="Ruby"></a>
  <a href="https://github.com/antybrowser/SDK"><img src="https://img.shields.io/github/stars/antybrowser/SDK?logo=github" alt="GitHub Stars"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>
</p>

---

## Prerequisites

- **Ruby >= 3.0**
- **Antybrowser** desktop app running with the Local API enabled

## 🚀 Key Features

- **Profile Management**: Programmatically create, configure, start, and stop isolated browser profiles.
- **Fingerprint Control**: Manage canvas, WebGL, Audio, and other browser fingerprints to prevent detection.
- **Workflow Automation**: Execute complex browser automation scripts via our internal runner.
- **Proxy Management**: Seamlessly integrate HTTP, SOCKS4, and SOCKS5 proxies with bulk verification.
- **Multi-Accounting**: Scale your operations across hundreds of accounts with complete isolation.
- **Sync & Cloud**: Monitor profile synchronization status and cloud-based settings.

## Installation

```bash
gem install antybrowser
```

Or in your Gemfile:

```ruby
gem "antybrowser"
```

## Quick Start

```ruby
require "antybrowser"

client = Antybrowser::Client.new("your_api_key")

# List profiles
profiles = client.get_profiles
profiles.each { |p| puts "#{p.name} (status: #{p.status})" }

# Start a profile
result = client.start_profile(123)
puts "Debug port: #{result['data']['debugPort']}"
```

## Configuration

```ruby
# Default (port 5173)
client = Antybrowser::Client.new("my_key")

# Custom port
client = Antybrowser::Client.new("my_key", port: 5174)

# Custom base URL
client = Antybrowser::Client.new("my_key", base_url: "http://10.0.0.5:5173")
```

## API Reference

### System

| Method | Description |
|--------|-------------|
| `get_status` | Check API connection status |
| `get_settings` | Get current settings |
| `get_sync_status` | Get sync queue status |
| `refresh_sync(profile_id: nil)` | Trigger a sync refresh |

### Profiles

| Method | Description |
|--------|-------------|
| `get_profiles` | List all profiles |
| `create_profile(data)` | Create a new profile |
| `update_profile(id, data)` | Update a profile |
| `delete_profile(id)` | Delete a profile |
| `start_profile(id)` | Start a profile (returns debug port) |
| `stop_profile(id)` | Stop a running profile |
| `duplicate_profile(id, name: nil)` | Duplicate a profile |

### Automations

| Method | Description |
|--------|-------------|
| `get_automations` | List all automations |
| `run_automation(id, profile_id:)` | Run an automation on a profile |

### Groups

| Method | Description |
|--------|-------------|
| `get_groups` | List all groups |
| `create_group(data)` | Create a group |
| `update_group(id, data)` | Update a group |
| `delete_group(id)` | Delete a group |

### Proxies

| Method | Description |
|--------|-------------|
| `get_proxies` | List all proxies |
| `create_proxy(data)` | Add a proxy (validates connection) |
| `check_proxy(host:, port:)` | Check a single proxy |
| `check_proxies_bulk(proxies)` | Check multiple proxies |
| `delete_proxy(id)` | Delete a proxy |

### Extensions

| Method | Description |
|--------|-------------|
| `get_extensions` | List all extensions |
| `delete_extension(id)` | Delete an extension |
| `get_profile_extensions(id)` | Get extensions for a profile |
| `set_profile_extensions(id, ids)` | Set extensions for a profile |

## Examples

### Create and launch a profile

```ruby
require "antybrowser"

client = Antybrowser::Client.new("your_api_key")

profile = client.create_profile(
  name: "My Profile",
  browser_type: "Chrome",
  os_fingerprint: "Windows",
  language: "en-US",
  use_fingerprint: true,
)

result = client.start_profile(profile.id)
puts "Debug port: #{result['data']['debugPort']}"
```

### Bulk proxy check

```ruby
results = client.check_proxies_bulk([
  "user:pass:1.2.3.4:8080",
  { host: "5.6.7.8", port: 3128, type: "socks5" },
])

results.each_with_index do |r, i|
  label = r.success ? r.details&.country : r.error_message
  puts "Proxy #{i + 1}: #{label}"
end
```

### Run an automation

```ruby
result = client.run_automation(42, profile_id: 123, variables: { "TARGET_URL" => "https://example.com" })

puts result.message # "Automation completed"
```

## Error Handling

```ruby
begin
  client.get_profiles
rescue Antybrowser::AntybrowserError => e
  puts "Status: #{e.status_code}"
  puts "Body: #{e.response_body}"
end
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
