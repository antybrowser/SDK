<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — Go</h1>

<p align="center">
  Official Go client for the Antybrowser Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.
</p>

<p align="center">
  <a href="https://pkg.go.dev/github.com/antybrowser/SDK/go"><img src="https://pkg.go.dev/badge/github.com/antybrowser/SDK/go.svg" alt="Go Reference"></a>
  <a href="https://github.com/antybrowser/SDK"><img src="https://img.shields.io/github/stars/antybrowser/SDK?logo=github" alt="GitHub Stars"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>
</p>

---

## Prerequisites

- Go 1.21+
- [Antybrowser](https://antybrowser.com) app installed and running

## 🚀 Key Features

- **Profile Management**: Programmatically create, configure, start, and stop isolated browser profiles.
- **Fingerprint Control**: Manage canvas, WebGL, Audio, and other browser fingerprints to prevent detection.
- **Workflow Automation**: Execute complex browser automation scripts via our internal runner.
- **Proxy Management**: Seamlessly integrate HTTP, SOCKS4, and SOCKS5 proxies with bulk verification.
- **Multi-Accounting**: Scale your operations across hundreds of accounts with complete isolation.
- **Sync & Cloud**: Monitor profile synchronization status and cloud-based settings.

## Installation

```bash
go get github.com/antybrowser/SDK/go
```

## Quick Start

```go
package main

import (
	"fmt"
	antybrowser "github.com/antybrowser/SDK/go"
)

func main() {
	client := antybrowser.NewClient("your_api_key")

	// List profiles
	profiles, _ := client.GetProfiles()
	for _, p := range profiles {
		fmt.Printf("%s (status: %s)\n", p.Name, *p.Status)
	}

	// Start a profile
	result, _ := client.StartProfile(123)
	fmt.Printf("Debug port: %d\n", result.Data.DebugPort)
}
```

## Configuration

```go
// Default (port 5173)
client := antybrowser.NewClient("my_key")

// Custom port
client := antybrowser.NewClient("my_key", antybrowser.WithPort(5174))

// Custom timeout
client := antybrowser.NewClient("my_key", antybrowser.WithTimeout(60*time.Second))

// Custom base URL
client := antybrowser.NewClient("my_key", antybrowser.WithBaseURL("http://10.0.0.5:5173"))
```

## Error Handling

```go
profiles, err := client.GetProfiles()
if err != nil {
	var apiErr *antybrowser.AntybrowserError
	if errors.As(err, &apiErr) {
		fmt.Printf("Status: %d\nBody: %s\n", apiErr.StatusCode, apiErr.ResponseBody)
	}
}
```

## API Reference

### System
| Method | Description |
|--------|-------------|
| `GetStatus()` | Check API connection status |
| `GetSettings()` | Get current application settings |
| `GetSyncStatus()` | Get sync queue status |
| `RefreshSync()` | Trigger a sync refresh |

### Profiles
| Method | Description |
|--------|-------------|
| `GetProfiles()` | List all profiles |
| `CreateProfile()` | Create a new profile |
| `UpdateProfile()` | Update a profile |
| `DeleteProfile()` | Delete a profile |
| `StartProfile()` | Start a profile (returns debug port) |
| `StopProfile()` | Stop a running profile |
| `DuplicateProfile()` | Duplicate a profile |

### Automations
| Method | Description |
|--------|-------------|
| `GetAutomations()` | List all automations |
| `RunAutomation()` | Run an automation on a profile |

### Groups
| Method | Description |
|--------|-------------|
| `GetGroups()` | List all groups |
| `CreateGroup()` | Create a group |
| `UpdateGroup()` | Update a group |
| `DeleteGroup()` | Delete a group |

### Proxies
| Method | Description |
|--------|-------------|
| `GetProxies()` | List all proxies |
| `CreateProxy()` | Add a proxy (validates connection) |
| `CheckProxy()` | Check a single proxy |
| `CheckProxiesBulk()` | Check multiple proxies at once |
| `DeleteProxy()` | Delete a proxy |

### Extensions
| Method | Description |
|--------|-------------|
| `GetExtensions()` | List all extensions |
| `DeleteExtension()` | Delete an extension |
| `GetProfileExtensions()` | Get extensions for a profile |
| `SetProfileExtensions()` | Set extensions for a profile |

## Examples

### Create and launch a profile

```go
profile, _ := client.CreateProfile(antybrowser.CreateProfileRequest{
	Name:          "Scraping Profile",
	BrowserType:   "Chrome",
	OSFingerprint: "Windows",
	Language:      "en-US",
	UseFingerprint: true,
})

result, _ := client.StartProfile(profile.ID)
fmt.Printf("Chrome launched on debug port: %d\n", result.Data.DebugPort)
```

### Bulk proxy check

```go
proxies := []antybrowser.CreateProxyRequest{
	{Host: "1.2.3.4", Port: 8080, Type: "http"},
	{Host: "5.6.7.8", Port: 1080, Type: "socks5"},
}

for _, proxy := range proxies {
	result, _ := client.CheckProxy(proxy)
	fmt.Printf("%s:%d — %s\n", proxy.Host, proxy.Port, result.Data.Status)
}
```

### Run an automation

```go
automations, _ := client.GetAutomations()
automation := automations[0]

_ = client.RunAutomation(automation.ID, antybrowser.RunAutomationRequest{
	ProfileID: profile.ID,
})
fmt.Println("Automation started")
```

---

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

[MIT](LICENSE)

---
*Antybrowser - The ultimate solution for secure and undetectable multi-accounting.*
