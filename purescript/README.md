# Antybrowser PureScript SDK

Client library for the [Antybrowser](https://antybrowser.com) Local API.

## Install

### Using Spago

```bash
spago install antybrowser
```

### Using npm (with purescript)

```bash
npm install purescript-affjax purescript-argonaut
spago install antybrowser
```

### Manual

Copy the `src/Antybrowser` directory into your project and add the required dependencies to `spago.dhall`:

```dhall
{ dependencies = [ "affjax", "argonaut", "console", "effect", "maybe", "prelude" ]
}
```

## Prerequisites

- [Antybrowser](https://antybrowser.com) desktop app running with the **Local API** enabled
- An **API key** from Antybrowser Settings → API
- Default port: **5173**

## Quick Start

```purescript
module Main where

import Prelude
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Console (log)
import Antybrowser (mkClient, getProfiles, startProfile)

main :: Effect Unit
main = launchAff_ do
  let client = mkClient "your_api_key"

  profiles <- getProfiles client
  log $ "Found " <> show (length profiles) <> " profiles"

  result <- startProfile client 123
  log $ "Debug port: " <> show result.debugPort
```

## Configuration

```purescript
-- Default client (port 5173)
let client = mkClient "your_api_key"

-- Custom port
let client = (mkClient "your_api_key") { baseUrl = "http://127.0.0.1:8080" }
```

## API Methods

### System

| Method | Description |
|--------|-------------|
| `getStatus client` | Health check (no auth) |
| `getSettings client` | Get all settings |
| `getSyncStatus client` | Sync queue status |
| `refreshSync client` | Trigger sync |

### Profiles

| Method | Description |
|--------|-------------|
| `getProfiles client` | List all profiles |
| `createProfile client req` | Create a profile |
| `updateProfile client id body` | Update a profile |
| `deleteProfile client id` | Delete a profile |
| `startProfile client id` | Start → returns debug port |
| `stopProfile client id` | Stop running profile |
| `duplicateProfile client id` | Clone a profile |

### Automations

| Method | Description |
|--------|-------------|
| `getAutomations client` | List automations |
| `runAutomation client id req` | Run automation on profile |

### Groups

| Method | Description |
|--------|-------------|
| `getGroups client` | List groups |
| `createGroup client req` | Create group |
| `updateGroup client id body` | Update group |
| `deleteGroup client id` | Delete group |

### Proxies

| Method | Description |
|--------|-------------|
| `getProxies client` | List proxies |
| `createProxy client req` | Add proxy (validates) |
| `checkProxy client opts` | Test single proxy |
| `checkProxiesBulk client proxies` | Test multiple proxies |
| `deleteProxy client id` | Delete proxy |

### Extensions

| Method | Description |
|--------|-------------|
| `getExtensions client` | List extensions |
| `deleteExtension client id` | Delete extension |
| `getProfileExtensions client id details` | Get profile extensions |
| `setProfileExtensions client id ids` | Set profile extensions |

## Error Handling

```purescript
import Antybrowser (mkClient, getProfiles)
import Antybrowser.Error (AntybrowserError(..))
import Effect.Exception (catchException, message)

main = launchAff_ do
  let client = mkClient "your_api_key"
  catchError (getProfiles client) \err ->
    log $ "Error: " <> show err
```

## License

[MIT](LICENSE) — Copyright (c) 2026 Antybrowser.com
