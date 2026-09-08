<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — PHP</h1>

<p align="center">Official PHP client for the Antybrowser Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.</p>

<p align="center">
  <a href="https://packagist.org/packages/antybrowser/sdk"><img src="https://img.shields.io/packagist/v/antybrowser/sdk.svg" alt="Packagist"></a>
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

- **PHP >= 8.1**
- **Antybrowser** desktop application installed and running with the Local API enabled

## 📦 Installation

```bash
composer require antybrowser/sdk
```

## 🛠 Quick Start

```php
use Antybrowser\SDK\AntybrowserClient;

$client = new AntybrowserClient(apiKey: 'your_key');

// List profiles
$profiles = $client->getProfiles();
foreach ($profiles as $profile) {
    echo "{$profile->name} (status: {$profile->status})\n";
}

// Start a profile
$result = $client->startProfile(123);
echo "Debug port: {$result['data']['debugPort']}\n";
```

## ⚙️ Configuration

```php
// Default (port 5173)
$client = new AntybrowserClient(apiKey: 'my_key');

// Custom port
$client = new AntybrowserClient(apiKey: 'my_key', port: 5174);

// Custom base URL
$client = new AntybrowserClient(apiKey: 'my_key', baseUrl: 'http://10.0.0.5:5173');
```

## 🚨 Error Handling

```php
use Antybrowser\SDK\AntybrowserError;

try {
    $profiles = $client->getProfiles();
} catch (AntybrowserError $e) {
    echo "Status: {$e->statusCode}\n";
    echo "Body: {$e->responseBody}\n";
}
```

## 📚 API Reference

### System
| Method | Description |
|--------|-------------|
| `getStatus()` | Check API connection status |
| `getSettings()` | Get current application settings |
| `getSyncStatus()` | Get sync queue status |
| `refreshSync($profileId?)` | Trigger a sync refresh |

### Profiles
| Method | Description |
|--------|-------------|
| `getProfiles()` | List all profiles |
| `createProfile($data)` | Create a new profile |
| `updateProfile($id, $data)` | Update a profile |
| `deleteProfile($id)` | Delete a profile |
| `startProfile($id)` | Start a profile (returns debug port) |
| `stopProfile($id)` | Stop a running profile |
| `duplicateProfile($id, $opts?)` | Duplicate a profile |

### Automations
| Method | Description |
|--------|-------------|
| `getAutomations()` | List all automations |
| `runAutomation($id, $data)` | Run an automation on a profile |

### Groups
| Method | Description |
|--------|-------------|
| `getGroups()` | List all groups |
| `createGroup($data)` | Create a group |
| `updateGroup($id, $data)` | Update a group |
| `deleteGroup($id)` | Delete a group |

### Proxies
| Method | Description |
|--------|-------------|
| `getProxies()` | List all proxies |
| `createProxy($data)` | Add a proxy (validates connection) |
| `checkProxy($data)` | Check a single proxy |
| `checkProxiesBulk($proxies)` | Check multiple proxies at once |
| `deleteProxy($id)` | Delete a proxy |

### Extensions
| Method | Description |
|--------|-------------|
| `getExtensions()` | List all extensions |
| `deleteExtension($id)` | Delete an extension |
| `getProfileExtensions($profileId)` | Get extensions for a profile |
| `setProfileExtensions($profileId, $ids)` | Set extensions for a profile |

## 💡 Examples

### Create and Launch a Profile

```php
use Antybrowser\SDK\AntybrowserClient;

$client = new AntybrowserClient(apiKey: 'your_key');

$profile = $client->createProfile([
    'name' => 'My Profile',
    'proxy' => 'socks5://user:pass@host:port'
]);

$result = $client->startProfile($profile['id']);
echo "Debug port: {$result['data']['debugPort']}\n";
```

### Bulk Proxy Check

```php
$proxies = [
    ['host' => '1.2.3.4', 'port' => 8080, 'type' => 'socks5'],
    ['host' => '5.6.7.8', 'port' => 1080, 'type' => 'socks5'],
];

$results = $client->checkProxiesBulk($proxies);
foreach ($results as $r) {
    echo "{$r['host']}:{$r['port']} — " . ($r['alive'] ? 'OK' : 'Failed') . "\n";
}
```

### Run an Automation

```php
$result = $client->runAutomation(42, [
    'profileId' => $profile['id'],
    'variables' => ['target_url' => 'https://example.com']
]);
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
