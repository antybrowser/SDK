# @antybrowser/sdk

Official Antybrowser TypeScript/JavaScript SDK for the Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.

[![npm version](https://img.shields.io/npm/v/@antybrowser/sdk.svg)](https://www.npmjs.com/package/@antybrowser/sdk)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Prerequisites

- **Antybrowser** desktop app running with the Local API enabled
- **Node.js >= 18** (uses native `fetch`)

## Installation

```bash
npm install @antybrowser/sdk
```

## Quick Start

```typescript
import { AntybrowserClient } from "@antybrowser/sdk";

// Connect to the local API (default port 5173)
const client = new AntybrowserClient("your_api_key_here");

// Or specify a custom port
const client = new AntybrowserClient({ apiKey: "your_key", port: 5174 });

// List all profiles
const profiles = await client.getProfiles();
console.log(profiles);

// Start a profile and get the debug port for Selenium/Puppeteer
const result = await client.startProfile(123);
console.log(`Debug port: ${result.data.debugPort}`);
```

## Configuration

```typescript
// Simple — API key only (uses default port 5173)
const client = new AntybrowserClient("my_api_key");

// Full options
const client = new AntybrowserClient({
  apiKey: "my_api_key",
  port: 5174,           // custom port (default: 5173)
  timeout: 60_000,      // request timeout in ms (default: 30000)
});
```

## API Reference

### System

| Method | Description |
|--------|-------------|
| `getStatus()` | Check API connection status |
| `getSettings()` | Get current settings |
| `getSyncStatus()` | Get sync queue status |
| `refreshSync(profileId?)` | Trigger a sync refresh |

### Profiles

| Method | Description |
|--------|-------------|
| `getProfiles()` | List all profiles |
| `createProfile(data)` | Create a new profile |
| `updateProfile(id, data)` | Update a profile |
| `deleteProfile(id)` | Delete a profile |
| `startProfile(id)` | Start a profile (returns debug port) |
| `stopProfile(id)` | Stop a running profile |
| `duplicateProfile(id, opts?)` | Duplicate a profile |

### Automations

| Method | Description |
|--------|-------------|
| `getAutomations()` | List all automations |
| `runAutomation(id, data)` | Run an automation on a profile |

### Groups

| Method | Description |
|--------|-------------|
| `getGroups()` | List all groups |
| `createGroup(data)` | Create a group |
| `updateGroup(id, data)` | Update a group |
| `deleteGroup(id)` | Delete a group |

### Proxies

| Method | Description |
|--------|-------------|
| `getProxies()` | List all proxies |
| `createProxy(data)` | Add a proxy (validates connection) |
| `checkProxy(data)` | Check a single proxy |
| `checkProxiesBulk(proxies)` | Check multiple proxies |
| `deleteProxy(id)` | Delete a proxy |

### Extensions

| Method | Description |
|--------|-------------|
| `getExtensions()` | List all extensions |
| `deleteExtension(id)` | Delete an extension |
| `getProfileExtensions(profileId)` | Get extensions for a profile |
| `setProfileExtensions(profileId, ids)` | Set extensions for a profile |

## Examples

### Create and launch a profile

```typescript
import { AntybrowserClient } from "@antybrowser/sdk";

const client = new AntybrowserClient("your_api_key");

// Create a profile
const profile = await client.createProfile({
  name: "My Profile",
  browserType: "Chrome",
  osFingerprint: "Windows",
  language: "en-US",
  useFingerprint: true,
});

// Start it
const result = await client.startProfile(profile.id);
console.log(`Connect via CDP at 127.0.0.1:${result.data.debugPort}`);
```

### Bulk proxy check

```typescript
const results = await client.checkProxiesBulk([
  "user:pass:1.2.3.4:8080",
  { host: "5.6.7.8", port: 3128, type: "socks5" },
]);

results.forEach((r, i) => {
  console.log(`Proxy ${i + 1}: ${r.success ? r.details?.country : r.errorMessage}`);
});
```

### Run an automation

```typescript
const result = await client.runAutomation(42, {
  profileId: 123,
  variables: { TARGET_URL: "https://example.com" },
});

console.log(result.message); // "Automation completed"
```

## Error Handling

```typescript
import { AntybrowserError } from "@antybrowser/sdk";

try {
  await client.getProfiles();
} catch (error) {
  if (error instanceof AntybrowserError) {
    console.error(`Status: ${error.statusCode}`);
    console.error(`Body: ${error.responseBody}`);
  }
}
```

## Links

- [Antybrowser Website](https://antybrowser.com)
- [GitHub Repository](https://github.com/antybrowser/SDK)

## License

MIT
