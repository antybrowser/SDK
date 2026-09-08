<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — C# / .NET</h1>

<p align="center">The official **Antybrowser .NET SDK** is a powerful library for C#, VB.NET, and F# developers to automate **anti-detect browser** management, **multi-accounting**, and **fingerprint manipulation**. Build scalable automation workflows with the same ease as the Antybrowser desktop application.</p>

<p align="center">
  <a href="https://www.nuget.org/packages/Antybrowser.SDK/"><img src="https://img.shields.io/nuget/v/Antybrowser.SDK.svg" alt="NuGet version"></a>
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

- **.NET Standard 2.0** or later (.NET Core 2.0+, .NET Framework 4.6.1+, or .NET 5+)
- **Antybrowser** desktop application installed and running with the Local API enabled

## 📦 Installation

Integrate the Antybrowser SDK into your project via the NuGet Package Manager:

```bash
dotnet add package Antybrowser.SDK
```

Or search for `Antybrowser.SDK` in the Visual Studio NuGet Manager.

## 🛠 Quick Start

To get started, ensure the **Antybrowser Local API Runner** is active on your machine.

### Initialize the Client

```csharp
using Antybrowser.SDK;
using Antybrowser.SDK.Models;

// Your API Key from Antybrowser Settings
string apiKey = "your_api_key_here";

// Initialize the Antybrowser client
using var client = new AntybrowserClient(apiKey);
```

### Manage Browser Profiles

```csharp
// List all available profiles
var profiles = await client.GetProfilesAsync();
foreach (var p in profiles)
{
    Console.WriteLine($"Found Profile: {p.Name} (Status: {p.Status})");
}

// Launch a profile by its ID
var launchResult = await client.StartProfileAsync(12345);
if (launchResult.Success)
{
    Console.WriteLine("Browser launched successfully!");
}
```

### Automate Workflows

```csharp
// Run a pre-defined automation script
var runResult = await client.RunAutomationAsync(987, new RunAutomationRequest
{
    ProfileId = "12345",
    Variables = new Dictionary<string, string> { { "target_url", "https://example.com" } }
});
```

## 📚 API Reference

The SDK provides comprehensive access to the Antybrowser ecosystem:

### System
| Method | Description |
|--------|-------------|
| `GetStatusAsync()` | Check API connection status |
| `GetSettingsAsync()` | Get current application settings |
| `GetSyncStatusAsync()` | Get sync queue status |
| `RefreshSyncAsync(profileId?)` | Trigger a sync refresh |

### Profiles
| Method | Description |
|--------|-------------|
| `GetProfilesAsync()` | List all profiles |
| `CreateProfileAsync(data)` | Create a new profile |
| `UpdateProfileAsync(id, data)` | Update a profile |
| `DeleteProfileAsync(id)` | Delete a profile |
| `StartProfileAsync(id)` | Start a profile (returns debug port) |
| `StopProfileAsync(id)` | Stop a running profile |
| `DuplicateProfileAsync(id, opts?)` | Duplicate a profile |

### Automations
| Method | Description |
|--------|-------------|
| `GetAutomationsAsync()` | List all automations |
| `RunAutomationAsync(id, data)` | Run an automation on a profile |

### Groups
| Method | Description |
|--------|-------------|
| `GetGroupsAsync()` | List all groups |
| `CreateGroupAsync(data)` | Create a group |
| `UpdateGroupAsync(id, data)` | Update a group |
| `DeleteGroupAsync(id)` | Delete a group |

### Proxies
| Method | Description |
|--------|-------------|
| `GetProxiesAsync()` | List all proxies |
| `CreateProxyAsync(data)` | Add a proxy (validates connection) |
| `CheckProxyAsync(data)` | Check a single proxy |
| `CheckProxiesBulkAsync(proxies)` | Check multiple proxies at once |
| `DeleteProxyAsync(id)` | Delete a proxy |

### Extensions
| Method | Description |
|--------|-------------|
| `GetExtensionsAsync()` | List all extensions |
| `DeleteExtensionAsync(id)` | Delete an extension |
| `GetProfileExtensionsAsync(profileId)` | Get extensions for a profile |
| `SetProfileExtensionsAsync(profileId, ids)` | Set extensions for a profile |

## 💡 Examples

### Create and Launch a Profile

```csharp
var profile = await client.CreateProfileAsync(new CreateProfileRequest
{
    Name = "My Profile",
    Proxy = "socks5://user:pass@host:port"
});

var result = await client.StartProfileAsync(profile.Id);
Console.WriteLine($"Debug port: {result.Data.DebugPort}");
```

### Bulk Proxy Check

```csharp
var proxies = new List<CheckProxyRequest>
{
    new() { Host = "1.2.3.4", Port = 8080, Type = "socks5" },
    new() { Host = "5.6.7.8", Port = 1080, Type = "socks5" }
};

var results = await client.CheckProxiesBulkAsync(proxies);
foreach (var r in results)
{
    Console.WriteLine($"{r.Host}:{r.Port} — {(r.Alive ? "OK" : "Failed")}");
}
```

### Run an Automation

```csharp
var result = await client.RunAutomationAsync(42, new RunAutomationRequest
{
    ProfileId = profile.Id.ToString(),
    Variables = new Dictionary<string, string>
    {
        { "target_url", "https://example.com" }
    }
});
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
