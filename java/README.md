# antybrowser-sdk (Java)

Official Antybrowser Java SDK for the Local API.

## Installation

### Maven

```xml
<dependency>
    <groupId>com.antybrowser</groupId>
    <artifactId>antybrowser-sdk</artifactId>
    <version>1.0.1</version>
</dependency>
```

### Gradle

```groovy
implementation 'com.antybrowser:antybrowser-sdk:1.0.1'
```

## Quick Start

```java
import com.antybrowser.sdk.*;
import java.util.*;

var client = new AntybrowserClient("your_api_key");

// List profiles
List<Profile> profiles = client.getProfiles();
for (Profile p : profiles) {
    System.out.println(p.getName() + " (" + p.getStatus() + ")");
}

// Start a profile
StartProfileResponse result = client.startProfile(123);
System.out.println("Debug port: " + result.getDebugPort());
```

## Configuration

```java
// Default (port 5173)
var client = new AntybrowserClient("my_key");

// Custom port
var client = new AntybrowserClient("my_key", 5174);

// Custom base URL
var client = new AntybrowserClient("my_key", 5173, "http://10.0.0.5:5173");
```

## Error Handling

```java
try {
    client.getProfiles();
} catch (AntybrowserException e) {
    System.out.println("Status: " + e.getStatusCode());
    System.out.println("Body: " + e.getResponseBody());
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
