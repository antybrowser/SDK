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

## Error Handling

```ruby
begin
  client.get_profiles
rescue Antybrowser::AntybrowserError => e
  puts "Status: #{e.status_code}"
  puts "Body: #{e.response_body}"
end
```

## API Methods

| Method | Description |
|--------|-------------|
| `get_status` | Check API connection |
| `get_settings` | Get settings |
| `get_sync_status` | Get sync status |
| `refresh_sync(profile_id: nil)` | Trigger sync |
| `get_profiles` | List profiles |
| `create_profile(data)` | Create profile |
| `update_profile(id, data)` | Update profile |
| `delete_profile(id)` | Delete profile |
| `start_profile(id)` | Start profile |
| `stop_profile(id)` | Stop profile |
| `duplicate_profile(id, name: nil)` | Duplicate profile |
| `get_automations` | List automations |
| `run_automation(id, profile_id:)` | Run automation |
| `get_groups` | List groups |
| `create_group(data)` | Create group |
| `update_group(id, data)` | Update group |
| `delete_group(id)` | Delete group |
| `get_proxies` | List proxies |
| `create_proxy(data)` | Create proxy |
| `check_proxy(host:, port:)` | Check proxy |
| `check_proxies_bulk(proxies)` | Bulk check |
| `delete_proxy(id)` | Delete proxy |
| `get_extensions` | List extensions |
| `delete_extension(id)` | Delete extension |
| `get_profile_extensions(id)` | Get profile extensions |
| `set_profile_extensions(id, ids)` | Set profile extensions |

---

## Links

- [Antybrowser Website](https://antybrowser.com)
- [GitHub Repository](https://github.com/antybrowser/SDK)
- [RubyGems Package](https://rubygems.org/gems/antybrowser)
- [npm Package](https://www.npmjs.com/package/@antybrowser/sdk)
- [PyPI Package](https://pypi.org/project/antybrowser/)
- [NuGet Package](https://www.nuget.org/packages/Antybrowser.SDK/)

## License

MIT
