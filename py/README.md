<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — Python</h1>

<p align="center">
  Official Python client for the Antybrowser Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.
</p>

<p align="center">
  <a href="https://pypi.org/project/antybrowser/"><img src="https://img.shields.io/pypi/v/antybrowser?color=3776AB&logo=python&logoColor=white" alt="PyPI"></a>
  <a href="https://pypi.org/project/antybrowser/"><img src="https://img.shields.io/pypi/pyversions/antybrowser" alt="Python"></a>
  <a href="https://github.com/antybrowser/SDK"><img src="https://img.shields.io/github/stars/antybrowser/SDK?logo=github" alt="GitHub Stars"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>
</p>

---

## Prerequisites

- **Python 3.8+**
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
pip install antybrowser
```

## Quick Start

```python
import asyncio
from antybrowser import AntybrowserClient, CreateProfileRequest

async def main():
    async with AntybrowserClient(api_key="your_key", port=5173) as client:
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

## Headless

Start a profile without a visible window; the returned `debugPort` is the CDP endpoint:

```python
result = await client.start_profile(123, headless=True)
print(result.data.debug_port)  # attach Playwright/Selenium over CDP
```

See [HEADLESS.md](../HEADLESS.md) for Puppeteer/Playwright/Selenium connection snippets and the measured headed-vs-headless fingerprint parity.

## Configuration

```python
# Simple
client = AntybrowserClient(api_key="my_key")

# Custom port
client = AntybrowserClient(api_key="my_key", port=5174)

# Full override
client = AntybrowserClient(api_key="my_key", base_url="http://10.0.0.5:5173")
```

## Context Manager

```python
async with AntybrowserClient(api_key="my_key") as client:
    profiles = await client.get_profiles()
# Connection automatically closed
```

## API Reference

### Profiles

| Method | Description |
|--------|-------------|
| `get_profiles()` | List all profiles (hidden ones included) |
| `create_profile(request)` | Create a new profile |
| `update_profile(id, **fields)` | Update a profile |
| `delete_profile(id)` | Delete a profile (Trash on paid plans) |
| `start_profile(id)` | Start a profile (returns debug port) |
| `stop_profile(id)` | Stop a running profile |
| `duplicate_profile(id, opts?)` | Duplicate a profile |

### Automations

| Method | Description |
|--------|-------------|
| `get_automations()` | List all automations |
| `run_automation(id, request)` | Run an automation on a profile |

### Groups

| Method | Description |
|--------|-------------|
| `get_groups()` | List all groups |
| `create_group(request)` | Create a group |
| `update_group(id, **fields)` | Update a group |
| `delete_group(id)` | Delete a group |

### Proxies

| Method | Description |
|--------|-------------|
| `get_proxies()` | List all proxies |
| `create_proxy(request)` | Add a proxy (validates connection) |
| `delete_proxy(id)` | Delete a proxy |

### Extensions

| Method | Description |
|--------|-------------|
| `get_extensions()` | List all extensions |
| `delete_extension(id)` | Delete an extension |

## Examples

### Create and launch a profile

```python
from antybrowser import AntybrowserClient, CreateProfileRequest

client = AntybrowserClient(api_key="your_api_key")

profile = await client.create_profile(CreateProfileRequest(
    name="My Profile",
    browser_type="Chrome",
    os_fingerprint="Windows",
    language="en-US",
    use_fingerprint=True,
))

result = await client.start_profile(profile.id)
print(f"Debug port: {result.data.debug_port}")
```

### Run an automation

```python
result = await client.run_automation(42, profile_id=123, variables={"TARGET_URL": "https://example.com"})

print(result.message)  # "Automation completed"
```

## Error Handling

```python
from antybrowser import AntybrowserError

try:
    await client.get_profiles()
except AntybrowserError as e:
    print(f"Status: {e.status_code}")
    print(f"Body: {e.response_body}")
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
