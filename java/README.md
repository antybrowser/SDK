<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — Java</h1>

<p align="center">
  Official Java client for the Antybrowser Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.
</p>

<p align="center">
  <a href="https://central.sonatype.com/artifact/com.antybrowser/antybrowser-sdk"><img src="https://img.shields.io/maven-central/v/com.antybrowser/antybrowser-sdk?color=orange&logo=apache-maven&logoColor=white" alt="Maven Central"></a>
  <a href="https://github.com/antybrowser/SDK"><img src="https://img.shields.io/github/stars/antybrowser/SDK?logo=github" alt="GitHub Stars"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>
</p>

---

## Prerequisites

- Java 11+
- [Antybrowser](https://antybrowser.com) app installed and running

## 🚀 Key Features

- **Profile Management**: Programmatically create, configure, start, and stop isolated browser profiles.
- **Fingerprint Control**: Manage canvas, WebGL, Audio, and other browser fingerprints to prevent detection.
- **Workflow Automation**: Execute complex browser automation scripts via our internal runner.
- **Proxy Management**: Seamlessly integrate HTTP, SOCKS4, and SOCKS5 proxies with bulk verification.
- **Multi-Accounting**: Scale your operations across hundreds of accounts with complete isolation.
- **Sync & Cloud**: Monitor profile synchronization status and cloud-based settings.

## Installation

### Maven

```xml
<dependency>
    <groupId>com.antybrowser</groupId>
    <artifactId>antybrowser-sdk</artifactId>
    <version>1.0.2</version>
</dependency>
```

### Gradle

```groovy
implementation 'com.antybrowser:antybrowser-sdk:1.0.2'
```

## Quick Start

```java
import com.antybrowser.sdk.*;
import java.util.*;

var client = new AntybrowserClient("your_api_key");

// List profiles
List<Profile> profiles = client.getProfiles();
for (Profile p : profiles) {
    System.out.println(p.getName() + " (" + p.getStatus() + ")");
}

// Start a profile
StartProfileResponse result = client.startProfile(123);
System.out.println("Debug port: " + result.getDebugPort());
```

## Configuration

```java
// Default (port 5173)
var client = new AntybrowserClient("my_key");

// Custom port
var client = new AntybrowserClient("my_key", 5174);

// Custom base URL
var client = new AntybrowserClient("my_key", 5173, "http://10.0.0.5:5173");
```

## Error Handling

```java
try {
    client.getProfiles();
} catch (AntybrowserException e) {
    System.out.println("Status: " + e.getStatusCode());
    System.out.println("Body: " + e.getResponseBody());
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

```java
Profile profile = client.createProfile(new CreateProfileRequest()
    .setName("Scraping Profile")
    .setBrowserType("Chrome")
    .setOsFingerprint("Windows")
    .setLanguage("en-US")
    .setUseFingerprint(true));

StartProfileResponse result = client.startProfile(profile.getId());
System.out.println("Chrome launched on debug port: " + result.getDebugPort());
```

### Bulk proxy check

```java
CreateProxyRequest[] proxies = {
    new CreateProxyRequest().setHost("1.2.3.4").setPort(8080).setType("http"),
    new CreateProxyRequest().setHost("5.6.7.8").setPort(1080).setType("socks5"),
};

for (CreateProxyRequest proxy : proxies) {
    CheckProxyResponse result = client.checkProxy(proxy);
    System.out.println(proxy.getHost() + ":" + proxy.getPort() + " — " + result.getStatus());
}
```

### Run an automation

```java
List<Automation> automations = client.getAutomations();
Automation automation = automations.get(0);

client.runAutomation(automation.getId(), new RunAutomationRequest()
    .setProfileId(profile.getId()));
System.out.println("Automation started");
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
