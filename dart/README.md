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

## API Methods

| Method | Description |
|--------|-------------|
| `getStatus()` | Check API connection |
| `getSettings()` | Get settings |
| `getSyncStatus()` | Get sync status |
| `refreshSync()` | Trigger sync |
| `getProfiles()` | List profiles |
| `createProfile(request)` | Create profile |
| `updateProfile(id, fields)` | Update profile |
| `deleteProfile(id)` | Delete profile |
| `startProfile(id)` | Start profile |
| `stopProfile(id)` | Stop profile |
| `duplicateProfile(id)` | Duplicate profile |
| `getAutomations()` | List automations |
| `runAutomation(id, profileId)` | Run automation |
| `getGroups()` | List groups |
| `createGroup(request)` | Create group |
| `updateGroup(id, fields)` | Update group |
| `deleteGroup(id)` | Delete group |
| `getProxies()` | List proxies |
| `createProxy(request)` | Create proxy |
| `checkProxy(data)` | Check proxy |
| `deleteProxy(id)` | Delete proxy |
| `getExtensions()` | List extensions |
| `deleteExtension(id)` | Delete extension |
| `getProfileExtensions(id)` | Get profile extensions |
| `setProfileExtensions(id, ids)` | Set profile extensions |

---

## Links

- [Antybrowser Website](https://antybrowser.com)
- [GitHub Repository](https://github.com/antybrowser/SDK)
- [pub.dev Package](https://pub.dev/packages/antybrowser)
- [npm Package](https://www.npmjs.com/package/@antybrowser/sdk)
- [PyPI Package](https://pypi.org/project/antybrowser/)
- [NuGet Package](https://www.nuget.org/packages/Antybrowser.SDK/)
- [RubyGems Package](https://rubygems.org/gems/antybrowser)

## License

MIT
