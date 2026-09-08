<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — Perl</h1>

<p align="center">
  Official Perl client for the Antybrowser Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.
</p>

<p align="center">
  <a href="https://metacpan.org/pod/Antybrowser::SDK"><img src="https://img.shields.io/badge/CPAN-Antybrowser::SDK-green" alt="CPAN"></a>
  <a href="https://github.com/antybrowser/SDK"><img src="https://img.shields.io/github/stars/antybrowser/SDK?style=social" alt="GitHub Stars"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg" alt="MIT License"></a>
</p>

---

## 📋 Prerequisites

- Perl 5+
- [Antybrowser](https://antybrowser.com) desktop app running on `http://127.0.0.1:5173`

## 🚀 Key Features

- **Profile Management**: Programmatically create, configure, start, and stop isolated browser profiles.
- **Fingerprint Control**: Manage canvas, WebGL, Audio, and other browser fingerprints to prevent detection.
- **Workflow Automation**: Execute complex browser automation scripts via our internal runner.
- **Proxy Management**: Seamlessly integrate HTTP, SOCKS4, and SOCKS5 proxies with bulk verification.
- **Multi-Accounting**: Scale your operations across hundreds of accounts with complete isolation.
- **Sync & Cloud**: Monitor profile synchronization status and cloud-based settings.

## Installation

### CPAN

```sh
cpan Antybrowser::SDK
```

### From source

```sh
perl Makefile.PL
make
make install
```

## Usage

```perl
use Antybrowser::SDK;

my $client = Antybrowser::SDK->new(api_key => 'your_api_key');

# List profiles
my $profiles = $client->get_profiles();

# Create a profile
my $profile = $client->create_profile({ name => 'My Profile' });

# Start a profile
my $result = $client->start_profile($profile->{id});

# Stop a profile
$client->stop_profile($profile->{id});

# Delete a profile
$client->delete_profile($profile->{id});
```

## API Reference

### Constructor

```perl
Antybrowser::SDK->new(api_key => 'key', port => 5173)
```

- `api_key` — your Antybrowser API key (required)
- `port` — API port (default: `5173`)
- `base_url` — override full base URL

### System

| Method | Description |
|--------|-------------|
| `get_status()` | Get system status |
| `get_settings()` | Get app settings |
| `get_sync_status()` | Get sync status |
| `refresh_sync($profile_id?)` | Trigger sync refresh |

### Profiles

| Method | Description |
|--------|-------------|
| `get_profiles()` | List all profiles |
| `create_profile($data)` | Create a new profile |
| `update_profile($id, $data)` | Update a profile |
| `delete_profile($id)` | Delete a profile |
| `start_profile($id)` | Start a profile browser |
| `stop_profile($id)` | Stop a profile browser |
| `duplicate_profile($id, $name?)` | Duplicate a profile |

### Automations

| Method | Description |
|--------|-------------|
| `get_automations()` | List automations |
| `run_automation($id, $profile_id)` | Run an automation |

### Groups

| Method | Description |
|--------|-------------|
| `get_groups()` | List groups |
| `create_group($data)` | Create a group |
| `update_group($id, $data)` | Update a group |
| `delete_group($id)` | Delete a group |

### Proxies

| Method | Description |
|--------|-------------|
| `get_proxies()` | List proxies |
| `create_proxy($data)` | Create a proxy |
| `check_proxy($data)` | Check proxy connectivity |
| `delete_proxy($id)` | Delete a proxy |

### Extensions

| Method | Description |
|--------|-------------|
| `get_extensions()` | List extensions |
| `delete_extension($id)` | Delete an extension |
| `get_profile_extensions($profile_id)` | List profile extensions |
| `set_profile_extensions($profile_id, $extension_ids)` | Set profile extensions |

## Examples

### Create and launch a profile

```perl
use Antybrowser::SDK;

my $client = Antybrowser::SDK->new(api_key => 'your_api_key');

my $profile = $client->create_profile({ name => 'My Profile' });
my $result = $client->start_profile($profile->{id});
print "Debug port: $result->{data}{debugPort}\n";
```

### Bulk proxy check

```perl
use Antybrowser::SDK;

my $client = Antybrowser::SDK->new(api_key => 'your_api_key');

for my $proxy (@{$client->get_proxies()}) {
    my $check = $client->check_proxy({
        host     => $proxy->{host},
        port     => $proxy->{port},
        username => $proxy->{username},
        password => $proxy->{password},
    });
    print "$proxy->{name}: $check->{data}{status}\n";
}
```

### Run an automation

```perl
use Antybrowser::SDK;

my $client = Antybrowser::SDK->new(api_key => 'your_api_key');

my $automations = $client->get_automations();
my $result = $client->run_automation($automations->[0]{id}, 1);
print "Automation started: $result\n";
```

## 🌐 Links

- [Antybrowser Website](https://antybrowser.com)
- [Documentation](https://docs.antybrowser.com)
- [GitHub Repository](https://github.com/antybrowser/SDK)
- [npm Package](https://www.npmjs.com/package/@antybrowser/sdk)
- [PyPI Package](https://pypi.org/project/antybrowser/)
- [Maven Central](https://central.sonatype.com/artifact/com.antybrowser/antybrowser-sdk)
- [NuGet Package](https://www.nuget.org/packages/Antybrowser.SDK/)
- [Go Module](https://github.com/antybrowser/SDK/tree/main/go)
- [crates.io](https://crates.io/crates/antybrowser)
- [RubyGems](https://rubygems.org/gems/antybrowser)
- [Packagist](https://packagist.org/packages/antybrowser/sdk)
- [Hex.pm](https://hex.pm/packages/antybrowser)
- [LuaRocks](https://luarocks.org/modules/antybrowser)
- [CPAN](https://metacpan.org/pod/Antybrowser::SDK)
- [pub.dev](https://pub.dev/packages/antybrowser)
- [Swift Package](https://github.com/antybrowser/SDK/tree/main/swift)
- [Julia Package](https://github.com/antybrowser/SDK/tree/main/julia)
- [R Package](https://cran.r-project.org/package=antybrowser)
- [Support](mailto:support@antybrowser.com)

## 📄 License

[MIT](LICENSE) — Copyright (c) 2026 [Antybrowser.com](https://antybrowser.com)

---
*Antybrowser - The ultimate solution for secure and undetectable multi-accounting.*
