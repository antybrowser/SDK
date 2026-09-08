# Antybrowser Nim SDK

Official Nim client for the [Antybrowser](https://antybrowser.com) Local API.

## Requirements

- Nim >= 1.6.0

## Installation

Using nimble:

```bash
nimble install antybrowser
```

Or add to your `.nimble` file:

```nim
requires "antybrowser >= 1.0.3"
```

## Usage

```nim
import antybrowser
import std/asyncdispatch
import std/options

proc main() {.async.} =
  # Create client
  let client = newAntybrowserClient("your-api-key", port = 5173)

  # Check status
  let status = await client.getStatus()
  echo "Status: ", status.status.get()

  # List profiles
  let profiles = await client.listProfiles()
  for p in profiles:
    echo "Profile: ", p.name.get()

  # Create a profile
  let req = newCreateProfileRequest("My Profile")
  let profile = await client.createProfile(req)
  echo "Created profile: ", profile.id.get()

  # Start a profile
  let startResp = await client.startProfile(profile.id.get())
  echo "Browser started on port: ", startResp.port.get()

  # Stop the profile
  let stopResp = await client.stopProfile(profile.id.get())
  echo "Stopped: ", stopResp.success

waitFor main()
```

## API Methods

### General
- `getStatus()` - Get API status

### Profiles
- `listProfiles()` - List all profiles
- `getProfile(profileId)` - Get a profile
- `createProfile(request)` - Create a profile
- `updateProfile(profileId, request)` - Update a profile
- `deleteProfile(profileId)` - Delete a profile
- `duplicateProfile(profileId, request)` - Duplicate a profile
- `startProfile(profileId)` - Start a profile
- `stopProfile(profileId)` - Stop a profile
- `getProfileFingerprint(profileId)` - Get profile fingerprint

### Proxies
- `listProxies()` - List all proxies
- `getProxy(proxyId)` - Get a proxy
- `createProxy(request)` - Create a proxy
- `deleteProxy(proxyId)` - Delete a proxy
- `checkProxy(proxyId)` - Check proxy connection

### Groups
- `listGroups()` - List all groups
- `getGroup(groupId)` - Get a group
- `createGroup(request)` - Create a group
- `updateGroup(groupId, request)` - Update a group
- `deleteGroup(groupId)` - Delete a group

### Extensions
- `listExtensions()` - List all extensions
- `installExtension(profileId, path)` - Install extension to profile
- `uninstallExtension(profileId, extensionId)` - Uninstall extension

### Automations
- `listAutomations()` - List all automations
- `runAutomation(request)` - Run an automation

### Settings
- `getSettings()` - Get settings
- `updateSettings(settings)` - Update settings

### Sync
- `getSyncStatus()` - Get sync status
- `triggerSync()` - Trigger sync

## License

MIT License - see [LICENSE](LICENSE) for details.
