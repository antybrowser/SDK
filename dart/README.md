<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — Dart</h1>

<p align="center">
  Official Dart client for the Antybrowser Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.
</p>

<p align="center">
  <a href="https://pub.dev/packages/antybrowser"><img src="https://img.shields.io/pub/v/antybrowser?color=0175C2&logo=dart&logoColor=white" alt="pub.dev"></a>
  <a href="https://github.com/antybrowser/SDK"><img src="https://img.shields.io/github/stars/antybrowser/SDK?logo=github" alt="GitHub Stars"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>
</p>

---

## Prerequisites

- Dart SDK >= 3.0
- [Antybrowser](https://antybrowser.com) app installed and running

## 🚀 Key Features

- **Profile Management**: Programmatically create, configure, start, and stop isolated browser profiles.
- **Fingerprint Control**: Manage canvas, WebGL, Audio, and other browser fingerprints to prevent detection.
- **Workflow Automation**: Execute complex browser automation scripts via our internal runner.
- **Proxy Management**: Seamlessly integrate HTTP, SOCKS4, and SOCKS5 proxies with bulk verification.
- **Multi-Accounting**: Scale your operations across hundreds of accounts with complete isolation.
- **Sync & Cloud**: Monitor profile synchronization status and cloud-based settings.

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  antybrowser: ^1.0.2
```

Then run:

```bash
dart pub get
```

## Quick Start

```dart
import 'package:antybrowser/antybrowser.dart';

void main() async {
  final client = AntybrowserClient(
    apiKey: 'your_key',
    port: 5173,
  );

  // List profiles
  final profiles = await client.getProfiles();
  for (final p in profiles) {
    print('${p.name} (status: ${p.status})');
  }

  // Create a profile
  final profile = await client.createProfile(CreateProfileRequest(
    name: 'My Profile',
    browserType: 'Chrome',
    osFingerprint: 'Windows',
    language: 'en-US',
    useFingerprint: true,
  ));

  // Start it
  final result = await client.startProfile(profile.id);
  print('Debug port: ${result['data']['debugPort']}');

  client.dispose();
}
```

## Configuration

```dart
// Default (port 5173)
final client = AntybrowserClient(apiKey: 'my_key');

// Custom port
final client = AntybrowserClient(apiKey: 'my_key', port: 5174);

// Custom base URL
final client = AntybrowserClient(
  apiKey: 'my_key',
  baseUrl: 'http://10.0.0.5:5173',
);
```

## Error Handling

```dart
try {
  await client.getProfiles();
} on AntybrowserException catch (e) {
  print('Status: ${e.statusCode}');
  print('Body: ${e.body}');
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
| `createProfile(request)` | Create a new profile |
| `updateProfile(id, fields)` | Update a profile |
| `deleteProfile(id)` | Delete a profile |
| `startProfile(id)` | Start a profile (returns debug port) |
| `stopProfile(id)` | Stop a running profile |
| `duplicateProfile(id)` | Duplicate a profile |

### Automations
| Method | Description |
|--------|-------------|
| `getAutomations()` | List all automations |
| `runAutomation(id, profileId)` | Run an automation on a profile |

### Groups
| Method | Description |
|--------|-------------|
| `getGroups()` | List all groups |
| `createGroup(request)` | Create a group |
| `updateGroup(id, fields)` | Update a group |
| `deleteGroup(id)` | Delete a group |

### Proxies
| Method | Description |
|--------|-------------|
| `getProxies()` | List all proxies |
| `createProxy(request)` | Add a proxy (validates connection) |
| `checkProxy(data)` | Check a single proxy |
| `deleteProxy(id)` | Delete a proxy |

### Extensions
| Method | Description |
|--------|-------------|
| `getExtensions()` | List all extensions |
| `deleteExtension(id)` | Delete an extension |
| `getProfileExtensions(id)` | Get extensions for a profile |
| `setProfileExtensions(id, ids)` | Set extensions for a profile |

## Examples

### Create and launch a profile

```dart
final profile = await client.createProfile(CreateProfileRequest(
  name: 'Scraping Profile',
  browserType: 'Chrome',
  osFingerprint: 'Windows',
  language: 'en-US',
  useFingerprint: true,
));

final result = await client.startProfile(profile.id);
print('Chrome launched on debug port: ${result['data']['debugPort']}');
```

### Bulk proxy check

```dart
final proxies = [
  CreateProxyRequest(host: '1.2.3.4', port: 8080, type: 'http'),
  CreateProxyRequest(host: '5.6.7.8', port: 1080, type: 'socks5'),
];

for (final proxy in proxies) {
  final result = await client.checkProxy(proxy);
  print('${proxy.host}:${proxy.port} — ${result['data']['status']}');
}
```

### Run an automation

```dart
final automations = await client.getAutomations();
final automation = automations.first;

await client.runAutomation(automation.id, RunAutomationRequest(
  profileId: profile.id,
));
print('Automation started');
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
