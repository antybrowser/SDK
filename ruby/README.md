# antybrowser (Ruby)

Official Antybrowser Ruby SDK for the Local API.

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

## Available Methods

- `get_status` / `get_settings` / `get_sync_status` / `refresh_sync`
- `get_profiles` / `create_profile` / `update_profile` / `delete_profile`
- `start_profile` / `stop_profile` / `duplicate_profile`
- `get_automations` / `run_automation`
- `get_groups` / `create_group` / `update_group` / `delete_group`
- `get_proxies` / `create_proxy` / `check_proxy` / `check_proxies_bulk` / `delete_proxy`
- `get_extensions` / `delete_extension` / `get_profile_extensions` / `set_profile_extensions`

## License

MIT
