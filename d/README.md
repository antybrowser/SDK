<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — D</h1>

<p align="center">
  Official D client for the Antybrowser Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.
</p>

<p align="center">
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>
</p>

---

## Prerequisites

- D compiler (DMD, LDC, or GDC)
- [dub](https://code.dlang.org/) package manager
- [Antybrowser](https://antybrowser.com) app installed and running

## Installation

```bash
dub fetch antybrowser
```

Or add to your `dub.json`:

```json
{
    "dependencies": {
        "antybrowser": "~>1.0.0"
    }
}
```

## Quick Start

```d
import antybrowser;
import std.stdio;

void main()
{
    auto client = new AntybrowserClient("your_api_key");

    // List profiles
    auto profiles = client.getProfiles();
    foreach (p; profiles)
    {
        writefln("%s (status: %s)", p.name, p.status.get("unknown"));
    }

    // Start a profile
    auto result = client.startProfile(123);
    writefln("Debug port: %d", result.data.debugPort);
}
```

## Configuration

```d
// Default (port 5173)
auto client = new AntybrowserClient("my_key");

// Custom port
auto client = new AntybrowserClient("my_key", 5174);

// Custom base URL
auto client = new AntybrowserClient("my_key", 5173, "http://10.0.0.5:5173");

// Custom timeout (milliseconds)
auto client = new AntybrowserClient("my_key", 5173, null, 60000);
```

## Error Handling

```d
import antybrowser;

try
{
    auto profiles = client.getProfiles();
}
catch (AntybrowserError e)
{
    writefln("Status: %d", e.statusCode);
    writefln("Body: %s", e.responseBody);
}
```

## API Reference

### System

| Method | Description |
|--------|-------------|
| `getStatus()` | Check API connection status |
| `getSettings()` | Get current application settings |
| `getSyncStatus()` | Get sync queue status |
| `refreshSync()` | Trigger a sync refresh |

### Profiles

| Method | Description |
|--------|-------------|
| `getProfiles()` | List all profiles |
| `createProfile()` | Create a new profile |
| `updateProfile()` | Update a profile |
| `deleteProfile()` | Delete a profile |
| `startProfile()` | Start a profile (returns debug port) |
| `stopProfile()` | Stop a running profile |
| `duplicateProfile()` | Duplicate a profile |

### Automations

| Method | Description |
|--------|-------------|
| `getAutomations()` | List all automations |
| `runAutomation()` | Run an automation on a profile |

### Groups

| Method | Description |
|--------|-------------|
| `getGroups()` | List all groups |
| `createGroup()` | Create a group |
| `updateGroup()` | Update a group |
| `deleteGroup()` | Delete a group |

### Proxies

| Method | Description |
|--------|-------------|
| `getProxies()` | List all proxies |
| `createProxy()` | Add a proxy (validates connection) |
| `checkProxy()` | Check a single proxy |
| `checkProxiesBulk()` | Check multiple proxies at once |
| `deleteProxy()` | Delete a proxy |

### Extensions

| Method | Description |
|--------|-------------|
| `getExtensions()` | List all extensions |
| `deleteExtension()` | Delete an extension |
| `getProfileExtensions()` | Get extensions for a profile |
| `setProfileExtensions()` | Set extensions for a profile |

## Examples

### Create and launch a profile

```d
import antybrowser;
import std.stdio;
import std.typecons;

void main()
{
    auto client = new AntybrowserClient("your_api_key");

    auto req = CreateProfileRequest("Scraping Profile");
    req.browserType = Nullable!string("Chrome");
    req.osFingerprint = Nullable!string("Windows");
    req.language = Nullable!string("en-US");
    req.useFingerprint = Nullable!bool(true);

    auto profile = client.createProfile(req);
    auto result = client.startProfile(profile.id);
    writefln("Chrome launched on debug port: %d", result.data.debugPort);
}
```

### Check a proxy

```d
import antybrowser;
import std.stdio;
import std.typecons;

void main()
{
    auto client = new AntybrowserClient("your_api_key");

    auto result = client.checkProxy("1.2.3.4", 8080);
    writefln("Success: %s", result.success);
}
```

### Run an automation

```d
import antybrowser;
import std.stdio;

void main()
{
    auto client = new AntybrowserClient("your_api_key");

    auto automations = client.getAutomations();
    if (automations.length > 0)
    {
        auto req = RunAutomationRequest(automations[0].id);
        req.profileId = 123;
        client.runAutomation(automations[0].id, req);
        writeln("Automation started");
    }
}
```

---

## 🌐 Links

- [Antybrowser Website](https://antybrowser.com)
- [Documentation](https://docs.antybrowser.com)
- [GitHub Repository](https://github.com/antybrowser/SDK)

---

## 📄 License

[MIT](LICENSE)

---

*Antybrowser - The ultimate solution for secure and undetectable multi-accounting.*
