# @antybrowser/sdk (Go)

Official Antybrowser Go SDK for the Local API.

## Installation

```bash
go get github.com/antybrowser/SDK/go
```

## Quick Start

```go
package main

import (
	"fmt"
	antybrowser "github.com/antybrowser/SDK/go"
)

func main() {
	client := antybrowser.NewClient("your_api_key")

	// List profiles
	profiles, _ := client.GetProfiles()
	for _, p := range profiles {
		fmt.Printf("%s (status: %s)\n", p.Name, *p.Status)
	}

	// Start a profile
	result, _ := client.StartProfile(123)
	fmt.Printf("Debug port: %d\n", result.Data.DebugPort)
}
```

## Configuration

```go
// Default (port 5173)
client := antybrowser.NewClient("my_key")

// Custom port
client := antybrowser.NewClient("my_key", antybrowser.WithPort(5174))

// Custom timeout
client := antybrowser.NewClient("my_key", antybrowser.WithTimeout(60*time.Second))

// Custom base URL
client := antybrowser.NewClient("my_key", antybrowser.WithBaseURL("http://10.0.0.5:5173"))
```

## Error Handling

```go
profiles, err := client.GetProfiles()
if err != nil {
	var apiErr *antybrowser.AntyBrowserError
	if errors.As(err, &apiErr) {
		fmt.Printf("Status: %d\nBody: %s\n", apiErr.StatusCode, apiErr.ResponseBody)
	}
}
```

## Available Methods

- `GetStatus()` / `GetSettings()` / `GetSyncStatus()` / `RefreshSync()`
- `GetProfiles()` / `CreateProfile()` / `UpdateProfile()` / `DeleteProfile()`
- `StartProfile()` / `StopProfile()` / `DuplicateProfile()`
- `GetAutomations()` / `RunAutomation()`
- `GetGroups()` / `CreateGroup()` / `UpdateGroup()` / `DeleteGroup()`
- `GetProxies()` / `CreateProxy()` / `CheckProxy()` / `CheckProxiesBulk()` / `DeleteProxy()`
- `GetExtensions()` / `DeleteExtension()` / `GetProfileExtensions()` / `SetProfileExtensions()`

## License

MIT
