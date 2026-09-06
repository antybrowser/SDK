# @antybrowser/sdk (Python)

Official Antybrowser Python SDK for the Local API.

[![PyPI version](https://img.shields.io/pypi/v/antybrowser.svg)](https://pypi.org/project/antybrowser/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Installation

```bash
pip install antybrowser
```

## Quick Start

```python
import asyncio
from antybrowser import AntyBrowserClient, CreateProfileRequest

async def main():
    async with AntyBrowserClient(api_key="your_key", port=5173) as client:
        # List profiles
        profiles = await client.get_profiles()
        for p in profiles:
            print(f"{p.name} (status: {p.status})")

        # Create a profile
        profile = await client.create_profile(CreateProfileRequest(
            name="My Profile",
            browser_type="Chrome",
            os_fingerprint="Windows",
            language="en-US",
            use_fingerprint=True,
        ))

        # Start it — get debug port for Selenium/Playwright
        result = await client.start_profile(profile.id)
        print(f"Debug port: {result.data.debug_port}")

asyncio.run(main())
```

## Configuration

```python
# Simple
client = AntyBrowserClient(api_key="my_key")

# Custom port
client = AntyBrowserClient(api_key="my_key", port=5174)

# Full override
client = AntyBrowserClient(api_key="my_key", base_url="http://10.0.0.5:5173")
```

## Context Manager

```python
async with AntyBrowserClient(api_key="my_key") as client:
    profiles = await client.get_profiles()
# Connection automatically closed
```

## API Methods

| Method | Description |
|--------|-------------|
| `get_status()` | Check API connection |
| `get_settings()` | Get settings |
| `get_sync_status()` | Get sync status |
| `refresh_sync(profile_id?)` | Trigger sync |
| `get_profiles()` | List profiles |
| `create_profile(request)` | Create profile |
| `update_profile(id, **fields)` | Update profile |
| `delete_profile(id)` | Delete profile |
| `start_profile(id)` | Start profile |
| `stop_profile(id)` | Stop profile |
| `duplicate_profile(id, opts?)` | Duplicate profile |
| `get_automations()` | List automations |
| `run_automation(id, request)` | Run automation |
| `get_groups()` | List groups |
| `create_group(request)` | Create group |
| `update_group(id, **fields)` | Update group |
| `delete_group(id)` | Delete group |
| `get_proxies()` | List proxies |
| `create_proxy(request)` | Create proxy |
| `check_proxy(host, port, ...)` | Check proxy |
| `check_proxies_bulk(proxies)` | Bulk check |
| `delete_proxy(id)` | Delete proxy |
| `get_extensions()` | List extensions |
| `delete_extension(id)` | Delete extension |
| `get_profile_extensions(id)` | Get profile extensions |
| `set_profile_extensions(id, ids)` | Set profile extensions |

## Error Handling

```python
from antybrowser import AntyBrowserError

try:
    await client.get_profiles()
except AntyBrowserError as e:
    print(f"Status: {e.status_code}")
    print(f"Body: {e.response_body}")
```

## License

MIT
