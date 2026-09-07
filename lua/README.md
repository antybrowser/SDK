# Antybrowser SDK for Lua

[![LuaRocks](https://img.shields.io/badge/LuaRocks-antybrowser-blue)](https://luarocks.org/modules/antybrowser)

Official Lua client for the [Antybrowser](https://antybrowser.com) Local API.

## Installation

### LuaRocks

```sh
luarocks install antybrowser
```

### Other SDKs

- [TypeScript/JavaScript](../typescript/) · [Python](../python/) · [C#](../csharp/) · [Go](../go/) · [PHP](../php/) · [Ruby](../ruby/) · [Java](../java/) · [Elixir](../elixir/) · [Perl](../perl/)

## Usage

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

## API

### Constructor

```lua
antybrowser.new(api_key, opts)
```

- `api_key` — your Antybrowser API key
- `opts` — optional table:
  - `port` — API port (default: `5173`)
  - `base_url` — override full base URL

### Methods

| Method | Description |
|---|---|
| `:get_status()` | Get system status |
| `:get_settings()` | Get app settings |
| `:get_sync_status()` | Get sync status |
| `:refresh_sync(profile_id?)` | Trigger sync refresh |
| `:get_profiles()` | List all profiles |
| `:create_profile(data)` | Create a new profile |
| `:update_profile(id, data)` | Update a profile |
| `:delete_profile(id)` | Delete a profile |
| `:start_profile(id)` | Start a profile browser |
| `:stop_profile(id)` | Stop a profile browser |
| `:duplicate_profile(id, name?)` | Duplicate a profile |
| `:get_automations()` | List automations |
| `:run_automation(id, profile_id)` | Run an automation |
| `:get_groups()` | List groups |
| `:create_group(data)` | Create a group |
| `:update_group(id, data)` | Update a group |
| `:delete_group(id)` | Delete a group |
| `:get_proxies()` | List proxies |
| `:create_proxy(data)` | Create a proxy |
| `:check_proxy(data)` | Check proxy connectivity |
| `:delete_proxy(id)` | Delete a proxy |
| `:get_extensions()` | List extensions |
| `:delete_extension(id)` | Delete an extension |
| `:get_profile_extensions(profile_id)` | List profile extensions |
| `:set_profile_extensions(profile_id, extension_ids)` | Set profile extensions |

## License

MIT
