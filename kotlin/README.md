# antybrowser-sdk (Kotlin)

Official Antybrowser Kotlin SDK for the Local API.

[![Maven Central](https://img.shields.io/maven-central/v/com.antybrowser/antybrowser-sdk?color=orange&logo=apache-maven&logoColor=white)](https://search.maven.org/artifact/com.antybrowser/antybrowser-sdk)
[![GitHub Stars](https://img.shields.io/github/stars/antybrowser/SDK?logo=github)](https://github.com/antybrowser/SDK)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Installation

### Gradle (Kotlin DSL)

```kotlin
implementation("com.antybrowser:antybrowser-sdk:1.0.2")
```

### Gradle (Groovy DSL)

```groovy
implementation 'com.antybrowser:antybrowser-sdk:1.0.2'
```

### Maven

```xml
<dependency>
    <groupId>com.antybrowser</groupId>
    <artifactId>antybrowser-sdk</artifactId>
    <version>1.0.2</version>
</dependency>
```

## Quick Start

```kotlin
import com.antybrowser.sdk.*

val client = AntybrowserClient("your_api_key")

// List profiles
val profiles = client.getProfiles()
profiles.forEach { println("${it.name} (${it.status})") }

// Start a profile
val result = client.startProfile(123)
println("Debug port: ${result.data["debugPort"]}")

// Auto-close with use {}
AntybrowserClient("your_api_key").use { client ->
    client.getProfiles()
}
```

## Configuration

```kotlin
// Default (port 5173)
val client = AntybrowserClient("my_key")

// Custom base URL
val client = AntybrowserClient("my_key", "http://10.0.0.5:5173")
```

## Error Handling

```kotlin
try {
    client.getProfiles()
} catch (e: AntybrowserException) {
    println("Status: ${e.statusCode}")
    println("Body: ${e.responseBody}")
}
```

## Available Methods

### System
- `getStatus()` / `getSettings()` / `getSyncStatus()` / `refreshSync()`

### Profiles
- `getProfiles()` / `createProfile()` / `updateProfile()` / `deleteProfile()`
- `startProfile()` / `stopProfile()` / `duplicateProfile()`

### Automations
- `getAutomations()` / `runAutomation()`

### Groups
- `getGroups()` / `createGroup()` / `updateGroup()` / `deleteGroup()`

### Proxies
- `getProxies()` / `createProxy()` / `checkProxy()` / `deleteProxy()`

### Extensions
- `getExtensions()` / `deleteExtension()` / `getProfileExtensions()` / `setProfileExtensions()`

## All SDKs

| Language | Package | Install |
|----------|---------|---------|
| [TypeScript / JavaScript](../npm/) | `@antybrowser/sdk` | `npm install @antybrowser/sdk` |
| [Python](../py/) | `antybrowser` | `pip install antybrowser` |
| [C# / .NET](../nuget/) | `Antybrowser.SDK` | `dotnet add package Antybrowser.SDK` |
| [Go](../go/) | `github.com/antybrowser/SDK/go` | `go get github.com/antybrowser/SDK/go` |
| [PHP](../php/) | `antybrowser/sdk` | `composer require antybrowser/sdk` |
| [Ruby](../ruby/) | `antybrowser` | `gem install antybrowser` |
| [Java](../java/) | `com.antybrowser:antybrowser-sdk` | Maven Central |
| **Kotlin** | `com.antybrowser:antybrowser-sdk` | Maven Central |

## License

[MIT](LICENSE)
