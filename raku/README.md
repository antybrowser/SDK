# Antybrowser::SDK

Official Raku client library for the [Antybrowser Local API](https://antybrowser.com).

## Installation

```bash
zef install Antybrowser::SDK
```

## Quick Start

```raku
use Antybrowser::SDK;

my $client = AntybrowserClient.new(api-key => 'your-api-key');

# Check API status
my $status = $client.get-status();
say "Antybrowser {$status.version} is {$status.status}";

# List profiles
my @profiles = $client.get-profiles();
say "Found {@profiles.elems} profiles";

# Create a profile
my $profile = $client.create-profile(
    CreateProfileRequest.new(
        name         => 'My Profile',
        browser-type => 'chrome',
        language     => 'en-US',
    )
);
say "Created profile #{$profile.id}";

# Start a profile
my $started = $client.start-profile($profile.id);
say "Debug port: {$started.data.debug-port}";

# Create a proxy
my $proxy = $client.create-proxy(
    CreateProxyRequest.new(
        name     => 'My Proxy',
        host     => '127.0.0.1',
        port     => 8080,
        type     => 'http',
        username => 'user',
        password => 'pass',
    )
);

# Check a proxy
my $check = $client.check-proxy(host => '127.0.0.1', port => 8080);
say "Proxy IP: {$check.details<ip>}";

# Groups
my $group = $client.create-group(
    CreateGroupRequest.new(name => 'Work', color => '#FF5722')
);

# Extensions
my @exts = $client.get-extensions();
$client.set-profile-extensions($profile.id, @exts.map(*.id));

# Stop a profile
$client.stop-profile($profile.id);

# Delete a profile
$client.delete-profile($profile.id);
```

## Configuration

```raku
# Default: connects to http://127.0.0.1:5173
my $client = AntybrowserClient.new(api-key => 'your-api-key');

# Custom port
my $client = AntybrowserClient.new(api-key => 'your-api-key', port => 8080);

# Full base URL override
my $client = AntybrowserClient.new(
    api-key   => 'your-api-key',
    base-url  => 'http://192.168.1.100:5173',
    timeout   => 60000,  # 60 seconds
);
```

## Error Handling

```raku
use Antybrowser::SDK;

try {
    my $client = AntybrowserClient.new(api-key => 'invalid');
    $client.get-profiles();
    CATCH {
        when AntybrowserError {
            say "Error: {.message}";
            say "HTTP Status: {.status-code}" if .status-code.defined;
            say "Response: {.response-body}" if .response-body.defined;
        }
    }
}
```

## API Reference

### System
| Method | Description |
|--------|-------------|
| `get-status()` | Get API status and version |
| `get-settings()` | Get application settings |
| `get-sync-status()` | Get cloud sync status |
| `refresh-sync(:profile-id)` | Trigger sync refresh |

### Profiles
| Method | Description |
|--------|-------------|
| `get-profiles()` | List all profiles |
| `create-profile($request)` | Create a new profile |
| `update-profile($id, $request)` | Update a profile |
| `delete-profile($id)` | Delete a profile |
| `start-profile($id)` | Start a profile browser |
| `stop-profile($id)` | Stop a profile browser |
| `duplicate-profile($id, :$options)` | Duplicate a profile |

### Automations
| Method | Description |
|--------|-------------|
| `get-automations()` | List all automations |
| `run-automation($id, $request)` | Run an automation |

### Groups
| Method | Description |
|--------|-------------|
| `get-groups()` | List all groups |
| `create-group($request)` | Create a group |
| `update-group($id, $request)` | Update a group |
| `delete-group($id)` | Delete a group |

### Proxies
| Method | Description |
|--------|-------------|
| `get-proxies()` | List all proxies |
| `create-proxy($request)` | Create a proxy |
| `check-proxy(:host, :port, ...)` | Check a single proxy |
| `check-proxies-bulk(@proxies)` | Check multiple proxies |
| `delete-proxy($id)` | Delete a proxy |

### Extensions
| Method | Description |
|--------|-------------|
| `get-extensions()` | List all extensions |
| `delete-extension($id)` | Delete an extension |
| `get-profile-extensions($id, :details)` | Get profile extensions |
| `set-profile-extensions($id, @ids)` | Set profile extensions |

## License

MIT License - see [LICENSE](LICENSE) for details.
