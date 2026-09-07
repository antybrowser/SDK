# Antybrowser.jl

[![Julia Package](https://img.shields.io/badge/Julia-1.6%2B-blue.svg)](https://julialang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Official Julia client for the [Antybrowser](https://antybrowser.com) Local API.

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

## Links

- [Antybrowser](https://antybrowser.com)
- [GitHub](https://github.com/antybrowser/SDK)
- [Issues](https://github.com/antybrowser/SDK/issues)
