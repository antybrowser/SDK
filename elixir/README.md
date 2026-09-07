# Antybrowser SDK for Elixir

[![Hex.pm](https://img.shields.io/hexpm/v/antybrowser)](https://hex.pm/packages/antybrowser)

Official Elixir client for the [Antybrowser](https://antybrowser.com) Local API.

## Installation

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

### Other SDKs

- [TypeScript/JavaScript](../typescript/) · [Python](../python/) · [C#](../csharp/) · [Go](../go/) · [PHP](../php/) · [Ruby](../ruby/) · [Java](../java/) · [Lua](../lua/) · [Perl](../perl/)

## Usage

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

## API

### Constructor

```elixir
Antybrowser.new(api_key, opts \\ [])
```

- `api_key` — your Antybrowser API key
- `opts` — keyword list:
  - `:port` — API port (default: `5173`)

### Functions

| Function | Description |
|---|---|
| `get_status/1` | Get system status |
| `get_settings/1` | Get app settings |
| `get_sync_status/1` | Get sync status |
| `refresh_sync/2` | Trigger sync refresh (optional `profile_id`) |
| `get_profiles/1` | List all profiles |
| `create_profile/2` | Create a new profile |
| `update_profile/3` | Update a profile |
| `delete_profile/2` | Delete a profile |
| `start_profile/2` | Start a profile browser |
| `stop_profile/2` | Stop a profile browser |
| `duplicate_profile/3` | Duplicate a profile (optional `name`) |
| `get_automations/1` | List automations |
| `run_automation/3` | Run an automation |
| `get_groups/1` | List groups |
| `create_group/2` | Create a group |
| `update_group/3` | Update a group |
| `delete_group/2` | Delete a group |
| `get_proxies/1` | List proxies |
| `create_proxy/2` | Create a proxy |
| `check_proxy/2` | Check proxy connectivity |
| `delete_proxy/2` | Delete a proxy |
| `get_extensions/1` | List extensions |
| `delete_extension/2` | Delete an extension |
| `get_profile_extensions/2` | List profile extensions |
| `set_profile_extensions/3` | Set profile extensions |

## License

MIT
