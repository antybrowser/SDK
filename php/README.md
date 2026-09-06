# antybrowser/sdk (PHP)

Official Antybrowser PHP SDK for the Local API.

[![Packagist](https://img.shields.io/packagist/v/antybrowser/sdk.svg)](https://packagist.org/packages/antybrowser/sdk)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Installation

```bash
composer require antybrowser/sdk
```

## Quick Start

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

## Configuration

```php
// Default (port 5173)
$client = new AntybrowserClient(apiKey: 'my_key');

// Custom port
$client = new AntybrowserClient(apiKey: 'my_key', port: 5174);

// Custom base URL
$client = new AntybrowserClient(apiKey: 'my_key', baseUrl: 'http://10.0.0.5:5173');
```

## Error Handling

```php
use Antybrowser\SDK\AntybrowserError;

try {
    $profiles = $client->getProfiles();
} catch (AntybrowserError $e) {
    echo "Status: {$e->statusCode}\n";
    echo "Body: {$e->responseBody}\n";
}
```

## Available Methods

- `getStatus()` / `getSettings()` / `getSyncStatus()` / `refreshSync()`
- `getProfiles()` / `createProfile()` / `updateProfile()` / `deleteProfile()`
- `startProfile()` / `stopProfile()` / `duplicateProfile()`
- `getAutomations()` / `runAutomation()`
- `getGroups()` / `createGroup()` / `updateGroup()` / `deleteGroup()`
- `getProxies()` / `createProxy()` / `checkProxy()` / `checkProxiesBulk()` / `deleteProxy()`
- `getExtensions()` / `deleteExtension()` / `getProfileExtensions()` / `setProfileExtensions()`

## License

MIT
