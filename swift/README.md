# Antybrowser Swift SDK

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2013+%20%7C%20macOS%2010.15+-blue.svg)](https://swift.org)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/antybrowser/SDK?style=social)](https://github.com/antybrowser/SDK)

A Swift client library for the [Antybrowser](https://antybrowser.com) Local API.

## Requirements

- Swift 5.9+
- iOS 13+ / macOS 10.15+
- Antybrowser desktop app running on `http://127.0.0.1:5173`

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/antybrowser/SDK", from: "1.0.0")
]
```

Or in Xcode: **File > Add Package Dependencies** and enter the repository URL.

## Usage

```swift
import AntybrowserSDK

let client = AntybrowserClient(apiKey: "your-api-key")

// List profiles
let profiles = try await client.getProfiles()

// Create a profile
let profile = try await client.createProfile(
    CreateProfileRequest(name: "My Profile")
)

// Start a profile
let result = try await client.startProfile(id: profile.id)
print("Debug port: \(result.data.debugPort)")

// Stop a profile
let _ = try await client.stopProfile(id: profile.id)
```

### Proxies

```swift
// Create a proxy
let proxy = try await client.createProxy(
    CreateProxyRequest(
        name: "US Proxy",
        host: "proxy.example.com",
        port: 8080,
        username: "user",
        password: "pass"
    )
)

// Check proxy
let check = try await client.checkProxy(data: [
    "host": "proxy.example.com",
    "port": 8080,
    "username": "user",
    "password": "pass"
])
```

### Groups

```swift
let group = try await client.createGroup(
    CreateGroupRequest(name: "Work Profiles", description: "Profiles for work tasks")
)
```

### Extensions

```swift
// List extensions
let extensions = try await client.getExtensions()

// Assign extensions to a profile
let _ = try await client.setProfileExtensions(
    profileId: 1,
    extensionIds: [1, 2, 3]
)
```

### Sync

```swift
let status = try await client.getSyncStatus()
print("Syncing: \(status.isSyncing), \(status.completed)/\(status.total)")

let _ = try await client.refreshSync()
```

## API Reference

| Method | Description |
|--------|-------------|
| `getStatus()` | Get system status |
| `getSettings()` | Get app settings |
| `getSyncStatus()` | Get sync status |
| `refreshSync(profileId:)` | Trigger sync refresh |
| `getProfiles()` | List all profiles |
| `createProfile(_:)` | Create a new profile |
| `updateProfile(id:data:)` | Update a profile |
| `deleteProfile(id:)` | Delete a profile |
| `startProfile(id:)` | Start a profile |
| `stopProfile(id:)` | Stop a profile |
| `duplicateProfile(id:name:)` | Duplicate a profile |
| `getAutomations()` | List automations |
| `runAutomation(id:profileId:)` | Run an automation |
| `getGroups()` | List groups |
| `createGroup(_:)` | Create a group |
| `updateGroup(id:data:)` | Update a group |
| `deleteGroup(id:)` | Delete a group |
| `getProxies()` | List proxies |
| `createProxy(_:)` | Create a proxy |
| `checkProxy(data:)` | Check proxy connectivity |
| `deleteProxy(id:)` | Delete a proxy |
| `getExtensions()` | List extensions |
| `deleteExtension(id:)` | Delete an extension |
| `getProfileExtensions(profileId:)` | Get profile extensions |
| `setProfileExtensions(profileId:extensionIds:)` | Set profile extensions |

## Error Handling

All API errors are thrown as `AntybrowserError`:

```swift
do {
    let profiles = try await client.getProfiles()
} catch AntybrowserError.apiError(let code, let body) {
    print("API error \(code): \(body)")
} catch {
    print("Unexpected error: \(error)")
}
```

## License

[MIT](LICENSE) - Copyright (c) 2026 [Antybrowser.com](https://antybrowser.com)
