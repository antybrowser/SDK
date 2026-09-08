# Antybrowser Zig SDK

A client library for the [Antybrowser](https://antybrowser.com) Local API, written in Zig.

## Requirements

- Zig 0.11.0 or later
- Antybrowser desktop application running locally

## Installation

### As a Zig package

Add this SDK as a dependency in your `build.zig.zon`:

```zig
.dependencies = .{
    .antybrowser = .{
        .url = "https://github.com/antybrowser/zig-sdk/archive/main.tar.gz",
        .hash = "...",
    },
},
```

Then in your `build.zig`:

```zig
const antybrowser_dep = b.dependency("antybrowser", .{
    .target = target,
    .optimize = optimize,
});
exe.root_module.addImport("antybrowser", antybrowser_dep.module("antybrowser"));
```

### Direct source

Copy the `src/` directory into your project and add the module in `build.zig`.

## Usage

```zig
const std = @import("std");
const antybrowser = @import("antybrowser");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Initialize client with your API key
    var client = antybrowser.AntybrowserClient.init(allocator, "your-api-key-here");
    defer client.deinit();

    // Optional: change port or base URL
    // client = client.withPort(5174);
    // client = client.withBaseUrl("http://my-host:5173");

    // Get server status
    const status = try client.getStatus();
    std.debug.print("Version: {s}\n", .{status.version orelse "unknown"});
    std.debug.print("Running: {}\n", .{status.running orelse false});

    // List all profiles
    const profiles = try client.listProfiles();
    for (profiles.data orelse &[_]antybrowser.types.Profile{}) |profile| {
        std.debug.print("Profile: {s}\n", .{profile.name orelse "unnamed"});
    }

    // Create a new profile
    const new_profile = try client.createProfile(.{
        .name = "My Profile",
        .os = "windows",
        .browser = "chrome",
    });
    std.debug.print("Created profile: {s}\n", .{new_profile.id orelse "unknown"});

    // Start a profile
    const started = try client.startProfile(new_profile.id orelse return error.MissingId);
    std.debug.print("Profile started on port: {d}\n", .{started.port orelse 0});

    // Create a proxy
    const proxy = try client.createProxy(.{
        .name = "My Proxy",
        .host = "proxy.example.com",
        .port = 8080,
        .username = "user",
        .password = "pass",
    });
    std.debug.print("Proxy created: {s}\n", .{proxy.id orelse "unknown"});
}
```

## API Reference

### Client Methods

| Method | HTTP | Endpoint | Description |
|--------|------|----------|-------------|
| `getStatus` | GET | `/api/status` | Get server status |
| `listProfiles` | GET | `/api/profiles` | List all profiles |
| `createProfile` | POST | `/api/profiles` | Create a new profile |
| `getProfile` | GET | `/api/profiles/{id}` | Get profile by ID |
| `updateProfile` | PUT | `/api/profiles/{id}` | Update a profile |
| `deleteProfile` | DELETE | `/api/profiles/{id}` | Delete a profile |
| `duplicateProfile` | POST | `/api/profiles/{id}/duplicate` | Duplicate a profile |
| `startProfile` | POST | `/api/profiles/{id}/start` | Start a profile |
| `stopProfile` | POST | `/api/profiles/{id}/stop` | Stop a profile |
| `listProxies` | GET | `/api/proxies` | List all proxies |
| `createProxy` | POST | `/api/proxies` | Create a new proxy |
| `getProxy` | GET | `/api/proxies/{id}` | Get proxy by ID |
| `deleteProxy` | DELETE | `/api/proxies/{id}` | Delete a proxy |
| `checkProxy` | POST | `/api/proxies/check` | Check proxy connectivity |
| `listGroups` | GET | `/api/groups` | List all groups |
| `createGroup` | POST | `/api/groups` | Create a new group |
| `getGroup` | GET | `/api/groups/{id}` | Get group by ID |
| `updateGroup` | PUT | `/api/groups/{id}` | Update a group |
| `deleteGroup` | DELETE | `/api/groups/{id}` | Delete a group |
| `listExtensions` | GET | `/api/extensions` | List all extensions |
| `installExtension` | POST | `/api/extensions/install` | Install an extension |
| `uninstallExtension` | DELETE | `/api/extensions/{id}` | Uninstall an extension |
| `runAutomation` | POST | `/api/automations/run` | Run an automation |
| `stopAutomation` | POST | `/api/automations/{id}/stop` | Stop an automation |
| `getAutomationStatus` | GET | `/api/automations/{id}/status` | Get automation status |
| `getSettings` | GET | `/api/settings` | Get settings |
| `updateSettings` | PUT | `/api/settings` | Update settings |

### Types

All types are defined in `src/types.zig`:

- `Profile` — Browser profile configuration
- `CreateProfileRequest` — Request body for creating/updating profiles
- `DuplicateProfileRequest` — Options for duplicating a profile
- `Proxy` — Proxy configuration
- `CreateProxyRequest` — Request body for creating proxies
- `ProxyCheckResult` — Result of a proxy connectivity check
- `Group` — Profile group
- `CreateGroupRequest` — Request body for creating/updating groups
- `Extension` — Browser extension
- `Automation` — Automation script
- `RunAutomationRequest` — Request body for running automations
- `RunAutomationResult` — Result of starting an automation
- `Settings` — Application settings
- `StatusResponse` — Server status information
- `StartProfileResponse` — Response from starting a profile
- `ApiResponse` — Generic API response

## Error Handling

All methods return `AntybrowserError`, which is a union of:

- `ApiError` — HTTP error responses (4xx/5xx)
- `HttpError` — Connection and transport errors
- `JsonError` — JSON parsing/serialization errors

```zig
const profile = client.getProfile("some-id") catch |err| {
    switch (err) {
        error.NotFound => std.debug.print("Profile not found\n", .{}),
        error.Unauthorized => std.debug.print("Invalid API key\n", .{}),
        error.ConnectionRefused => std.debug.print("Is Antybrowser running?\n", .{}),
        else => std.debug.print("Error: {}\n", .{err}),
    }
    return;
};
```

## Configuration

```zig
// Change the port (default: 5173)
var client = antybrowser.AntybrowserClient.init(allocator, "api-key");
client = client.withPort(5174);

// Use a custom base URL
client = client.withBaseUrl("http://my-server:5173");
```

## License

MIT — see [LICENSE](LICENSE).
