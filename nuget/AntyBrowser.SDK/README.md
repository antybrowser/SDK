# AntyBrowser .NET SDK - Advanced Anti-Detect Browser Automation

The official **AntyBrowser .NET SDK** is a powerful library for C#, VB.NET, and F# developers to automate **anti-detect browser** management, **multi-accounting**, and **fingerprint manipulation**. Build scalable automation workflows with the same ease as the Antybrowser desktop application.

[![NuGet version](https://img.shields.io/nuget/v/AntyBrowser.SDK.svg)](https://www.nuget.org/packages/AntyBrowser.SDK/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🚀 Key Features

- **Profile Management**: Programmatically create, configure, start, and stop isolated browser profiles.
- **Fingerprint Control**: Manage canvas, WebGL, Audio, and other browser fingerprints to prevent detection.
- **Workflow Automation**: Execute complex browser automation scripts via our internal runner.
- **Proxy Management**: Seamlessly integrate HTTP, SOCKS4, and SOCKS5 proxies with bulk verification.
- **Multi-Accounting**: Scale your operations across hundreds of accounts with complete isolation.
- **Sync & Cloud**: Monitor profile synchronization status and cloud-based settings.

## 📦 Installation

Integrate the Antybrowser SDK into your project via the NuGet Package Manager:

```bash
dotnet add package AntyBrowser.SDK
```

Or search for `AntyBrowser.SDK` in the Visual Studio NuGet Manager.

## 🛠 Quick Start

To get started, ensure the **Antybrowser Local API Runner** is active on your machine.

### Initialize the Client

```csharp
using AntyBrowser.SDK;
using AntyBrowser.SDK.Models;

// Your API Key from Antybrowser Settings
string apiKey = "your_api_key_here";

// Initialize the Antybrowser client
using var client = new AntyBrowserClient(apiKey);
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

- **Profiles**: `GetProfilesAsync`, `CreateProfileAsync`, `UpdateProfileAsync`, `DeleteProfileAsync`, `DuplicateProfileAsync`, `StartProfileAsync`, `StopProfileAsync`.
- **Proxies**: `GetProxiesAsync`, `CreateProxyAsync`, `DeleteProxyAsync`, `CheckProxyAsync`, `CheckProxiesBulkAsync`.
- **Automations**: `GetAutomationsAsync`, `RunAutomationAsync`.
- **Groups**: `GetGroupsAsync`, `CreateGroupAsync`, `UpdateGroupAsync`, `DeleteGroupAsync`.
- **Extensions**: `GetExtensionsAsync`, `GetProfileExtensionsAsync`, `SetProfileExtensionsAsync`.

## 🌐 Useful Links

- **Official Website**: [https://antybrowser.com](https://antybrowser.com)
- **Documentation**: [https://docs.antybrowser.com](https://docs.antybrowser.com)
- **GitHub Repository**: [https://github.com/antybrowser/AntyBrowser.NET.SDK](https://github.com/antybrowser/AntyBrowser.NET.SDK)
- **Support**: [support@antybrowser.com](mailto:support@antybrowser.com)

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---
*AntyBrowser - The ultimate solution for secure and undetectable multi-accounting.*
