<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK</h1>

<p align="center">
  Official SDKs for the Antybrowser Local API — 23 languages, one API.
</p>

<p align="center">
  <a href="https://www.npmjs.com/package/@antybrowser/sdk"><img src="https://img.shields.io/npm/v/@antybrowser/sdk?color=cb3837&logo=npm" alt="npm"></a>
  <a href="https://www.nuget.org/packages/Antybrowser.SDK/"><img src="https://img.shields.io/nuget/v/Antybrowser.SDK?logo=nuget" alt="NuGet"></a>
  <a href="https://pypi.org/project/antybrowser/"><img src="https://img.shields.io/pypi/v/antybrowser?color=3776AB&logo=python&logoColor=white" alt="PyPI"></a>
  <a href="https://rubygems.org/gems/antybrowser"><img src="https://img.shields.io/gem/v/antybrowser?color=CC342D&logo=rubygems&logoColor=white" alt="RubyGems"></a>
  <a href="https://packagist.org/packages/antybrowser/sdk"><img src="https://img.shields.io/packagist/v/antybrowser/sdk?color=8892BF&logo=php" alt="Packagist"></a>
  <a href="https://search.maven.org/artifact/com.antybrowser/antybrowser-sdk"><img src="https://img.shields.io/maven-central/v/com.antybrowser/antybrowser-sdk?color=orange&logo=apache-maven&logoColor=white" alt="Maven Central"></a>
  <a href="https://metacpan.org/pod/Antybrowser::SDK"><img src="https://img.shields.io/cpan/v/Antybrowser-SDK?color=green&logo=perl" alt="CPAN"></a>
  <a href="https://github.com/antybrowser/SDK"><img src="https://img.shields.io/github/stars/antybrowser/SDK?logo=github" alt="GitHub Stars"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>
</p>

---

## Install

| Language | Registry | Install |
|----------|----------|---------|
| **TypeScript / JavaScript** | npm | `npm install @antybrowser/sdk` |
| **Python** | PyPI | `pip install antybrowser` |
| **C# / .NET** | NuGet | `dotnet add package Antybrowser.SDK` |
| **Go** | Go Modules | `go get github.com/antybrowser/SDK/go` |
| **PHP** | Packagist | `composer require antybrowser/sdk` |
| **Ruby** | RubyGems | `gem install antybrowser` |
| **Perl** | CPAN | `cpan Antybrowser::SDK` |
| **Java** | Maven Central | See [Java README](java/README.md) |
| **Kotlin** | Maven Central | See [Kotlin README](kotlin/README.md) |
| **Rust** | crates.io | `cargo add antybrowser` |
| **Dart / Flutter** | pub.dev | `dart pub add antybrowser` |
| **Swift** | Swift Package Manager | See [Swift README](swift/README.md) |
| **Elixir** | Hex | `mix deps.get antybrowser` |
| **Lua** | LuaRocks | `luarocks install antybrowser` |
| **Julia** | Julia Packages | `Pkg.add("Antybrowser")` |
| **R** | CRAN | `install.packages("antybrowser")` |
| **Haskell** | Hackage | `cabal install antybrowser-sdk` |
| **OCaml** | OPAM | `opam install antybrowser` |
| **Nim** | Nimble | `nimble install antybrowser` |
| **Zig** | Zig Network | See [Zig README](zig/README.md) |
| **C / C++** | vcpkg / Conan | See [C++ README](cpp/README.md) |
| **PureScript** | Pursuit | `spago install antybrowser` |
| **Raku** | Raku Modules | `zef install Antybrowser::SDK` |
| **D** | DUB | `dub fetch antybrowser` |

## Prerequisites

- [Antybrowser](https://antybrowser.com) desktop app running with the **Local API** enabled
- An **API key** from Antybrowser Settings → API
- Default port: **5173** (configurable per client)

---

## Quick Start

### TypeScript / JavaScript

```typescript
import { AntybrowserClient } from "@antybrowser/sdk";

const client = new AntybrowserClient({ apiKey: "your_key", port: 5173 });

const profiles = await client.getProfiles();
console.log(profiles);

const result = await client.startProfile(123);
console.log(`Debug port: ${result.data.debugPort}`);
```

### Python

```python
import asyncio
from antybrowser import AntybrowserClient, CreateProfileRequest

async def main():
    async with AntybrowserClient(api_key="your_key") as client:
        profiles = await client.get_profiles()
        
        result = await client.start_profile(123)
        print(f"Debug port: {result.data.debug_port}")

asyncio.run(main())
```

### C# / .NET

```csharp
using Antybrowser.SDK;

using var client = new AntybrowserClient("your_api_key");
var profiles = await client.GetProfilesAsync();
var result = await client.StartProfileAsync(123);
Console.WriteLine($"Debug port: {result.Data.DebugPort}");
```

### Go

```go
import antybrowser "github.com/antybrowser/SDK/go"

client := antybrowser.NewClient("your_key", antybrowser.WithPort(5173))
profiles, _ := client.GetProfiles()
result, _ := client.StartProfile(123)
fmt.Printf("Debug port: %d\n", result.Data.DebugPort)
```

### PHP

```php
use Antybrowser\SDK\AntybrowserClient;

$client = new AntybrowserClient(apiKey: 'your_key');
$profiles = $client->getProfiles();
$result = $client->startProfile(123);
echo "Debug port: {$result['data']['debugPort']}\n";
```

### Ruby

```ruby
require "antybrowser"

client = Antybrowser::Client.new("your_key")
profiles = client.get_profiles
result = client.start_profile(123)
puts "Debug port: #{result['data']['debugPort']}"
```

### Java

```java
import com.antybrowser.sdk.*;

var client = new AntybrowserClient("your_key");
var profiles = client.getProfiles();
var result = client.startProfile(123);
System.out.println("Debug port: " + result.getDebugPort());
```

### Rust

```rust
use antybrowser::AntybrowserClient;

let client = AntybrowserClient::new("your_key")?;
let profiles = client.get_profiles()?;
let result = client.start_profile(123)?;
println!("Debug port: {:?}", result.data.debug_port);
```

### Haskell

```haskell
import Antybrowser

main = do
  client <- newClient "your_key" Nothing Nothing Nothing
  profiles <- getProfiles client
  print profiles
```

### C++

```cpp
#include <antybrowser/antybrowser.hpp>

antybrowser::AntybrowserClient client("your_key");
auto profiles = client.getProfiles();
auto result = client.startProfile(123);
std::cout << "Debug port: " << result["data"]["debugPort"] << std::endl;
```

---

## Configuration

Every SDK supports the same options:

| Option | Default | Description |
|--------|---------|-------------|
| `apiKey` | *(required)* | Your Antybrowser API key |
| `port` | `5173` | Local API port |
| `baseUrl` | `http://127.0.0.1:{port}` | Full URL override |
| `timeout` | `30s` | Request timeout |

---

## API Methods

All 23 SDKs implement the same 26 endpoints:

### System
| Method | Description |
|--------|-------------|
| `getStatus()` | Health check (no auth) |
| `getSettings()` | Get all settings |
| `getSyncStatus()` | Sync queue status |
| `refreshSync(profileId?)` | Trigger sync |

### Profiles
| Method | Description |
|--------|-------------|
| `getProfiles()` | List all profiles |
| `createProfile(data)` | Create a profile |
| `updateProfile(id, data)` | Update a profile |
| `deleteProfile(id)` | Delete a profile |
| `startProfile(id)` | Start → returns debug port |
| `stopProfile(id)` | Stop running profile |
| `duplicateProfile(id)` | Clone a profile |

### Automations
| Method | Description |
|--------|-------------|
| `getAutomations()` | List automations |
| `runAutomation(id, data)` | Run automation on profile |

### Groups
| Method | Description |
|--------|-------------|
| `getGroups()` | List groups |
| `createGroup(data)` | Create group |
| `updateGroup(id, data)` | Update group |
| `deleteGroup(id)` | Delete group |

### Proxies
| Method | Description |
|--------|-------------|
| `getProxies()` | List proxies |
| `createProxy(data)` | Add proxy (validates) |
| `checkProxy(data)` | Test single proxy |
| `checkProxiesBulk(proxies)` | Test multiple proxies |
| `deleteProxy(id)` | Delete proxy |

### Extensions
| Method | Description |
|--------|-------------|
| `getExtensions()` | List extensions |
| `deleteExtension(id)` | Delete extension |
| `getProfileExtensions(id)` | Get profile extensions |
| `setProfileExtensions(id, ids)` | Set profile extensions |

---

## Error Handling

Every SDK has a typed error class with `statusCode` and `responseBody`:

```typescript
// TypeScript
import { AntybrowserError } from "@antybrowser/sdk";
try { ... } catch (e) {
  if (e instanceof AntybrowserError) {
    console.error(e.statusCode, e.responseBody);
  }
}
```

```python
# Python
from antybrowser import AntybrowserError
try: ...
except AntybrowserError as e:
    print(e.status_code, e.response_body)
```

---

## Publishing

See [PUBLISHING.md](PUBLISHING.md) for the full checklist — registry tokens, first-time setup, and version bump workflow.

---

## Additional Registries & Backlinks

Beyond the 23 language registries, list your package here for discoverability:

| Platform | Type | Action |
|----------|------|--------|
| [Libraries.io](https://libraries.io) | Package aggregator | Auto-indexes — verify listing |
| [OpenLib](https://openlib.net) | Package catalog | Auto-indexes from registries |
| [JSR](https://jsr.io) | TS registry (Deno) | `npx jsr publish` |
| [GitHub Packages](https://github.com/features/packages) | GH registry | `gh package publish` |
| [Product Hunt](https://producthunt.com) | Launch platform | Submit as product |
| [Hacker News](https://news.ycombinator.com) | Community | Post "Show HN" |
| [Dev.to](https://dev.to) | Developer blog | Write launch article |
| [Reddit](https://reddit.com) | Community | r/programming, r/python, r/webdev |
| [Indie Hackers](https://indiehackers.com) | Founder community | Share story |
| [Awesome lists](https://github.com/sindresorhus/awesome) | Curated lists | PR to relevant repos |
| [Smithery](https://smithery.ai) | AI tool registry | Submit at smithery.ai/new |
| [Glama](https://glama.ai) | MCP directory | Auto-indexed from GitHub topics |
| [SourceForge](https://sourceforge.net) | Code hosting | Mirror repo |
| [CodeProject](https://codeproject.com) | Developer articles | Write tutorial |

---

## Project Structure

```
SDK/
├── npm/            @antybrowser/sdk (TypeScript/JavaScript)
├── py/             antybrowser (Python)
├── nuget/          Antybrowser.SDK (C#/.NET)
├── go/             github.com/antybrowser/SDK/go
├── php/            antybrowser/sdk (Composer)
├── ruby/           antybrowser (RubyGems)
├── perl/           Antybrowser::SDK (CPAN)
├── java/           com.antybrowser:antybrowser-sdk (Maven)
├── kotlin/         com.antybrowser:antybrowser-sdk (Maven/Kotlin DSL)
├── rust/           antybrowser (crates.io)
├── dart/           antybrowser (pub.dev)
├── swift/          AntybrowserSDK (Swift Package Manager)
├── elixir/         antybrowser (Hex)
├── lua/            antybrowser (LuaRocks)
├── julia/          Antybrowser (Julia Packages)
├── r/              antybrowser (CRAN)
├── haskell/        antybrowser-sdk (Hackage)
├── ocaml/          antybrowser (OPAM)
├── nim/            antybrowser (Nimble)
├── zig/            antybrowser (Zig Network)
├── cpp/            antybrowser (vcpkg/Conan)
├── purescript/     antybrowser (Pursuit)
├── raku/           Antybrowser::SDK (Raku Modules)
├── d/              antybrowser (DUB)
└── .github/        CI/CD workflows
```

## License

[MIT](LICENSE)
