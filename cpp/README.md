# Antybrowser SDK — C++ (1.0.3)

Official C++ client library for the [Antybrowser](https://antybrowser.com) Local API.

Header-only, C++17, uses **libcurl** for HTTP and **nlohmann/json** for JSON.

## Requirements

- C++17 compiler
- libcurl
- nlohmann/json

## Install with vcpkg

```bash
vcpkg install curl nlohmann-json
```

Then in your `CMakeLists.txt`:

```cmake
find_package(CURL REQUIRED)
find_package(nlohmann_json CONFIG REQUIRED)

add_executable(my_app main.cpp)
target_link_libraries(my_app PRIVATE antybrowser CURL::libcurl nlohmann_json::nlohmann_json)
```

## Install with Conan

```bash
conan install antybrowser/1.0.3 --output-folder=build --build=missing
```

## Manual

Copy the `include/antybrowser/` directory into your project and link libcurl.

## Usage

```cpp
#include <antybrowser/antybrowser.hpp>
#include <iostream>

int main() {
    antybrowser::AntybrowserClient client("YOUR_API_KEY");

    auto status = client.get_status();
    std::cout << "Version: " << status.version << "\n";

    auto profiles = client.get_profiles();
    for (const auto& p : profiles) {
        std::cout << p.name << "\n";
    }

    antybrowser::CreateProfileRequest req;
    req.name = "My Profile";
    auto profile = client.create_profile(req);
    std::cout << "Created profile: " << profile.id << "\n";

    auto start_resp = client.start_profile(profile.id);
    if (start_resp.success) {
        std::cout << "Debug port: " << *start_resp.data.debug_port << "\n";
    }

    return 0;
}
```

## Building with CMake

```bash
mkdir build && cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=[vcpkg-root]/scripts/buildsystems/vcpkg.cmake
cmake --build .
```

## API Coverage

| Endpoint | Method |
|---|---|
| GET /api/status | `get_status()` |
| GET /api/settings | `get_settings()` |
| GET /api/sync/status | `get_sync_status()` |
| POST /api/sync/refresh | `refresh_sync()` |
| GET /api/profiles | `get_profiles()` |
| POST /api/profiles | `create_profile()` |
| PUT /api/profiles/:id | `update_profile()` |
| DELETE /api/profiles/:id | `delete_profile()` |
| POST /api/profiles/:id/start | `start_profile()` |
| POST /api/profiles/:id/stop | `stop_profile()` |
| POST /api/profiles/:id/duplicate | `duplicate_profile()` |
| GET /api/automations | `get_automations()` |
| POST /api/automations/:id/run | `run_automation()` |
| GET /api/groups | `get_groups()` |
| POST /api/groups | `create_group()` |
| PUT /api/groups/:id | `update_group()` |
| DELETE /api/groups/:id | `delete_group()` |
| GET /api/proxies | `get_proxies()` |
| POST /api/proxies | `create_proxy()` |
| POST /api/proxies/check | `check_proxy()` |
| POST /api/proxies/check-bulk | `check_proxies_bulk()` |
| DELETE /api/proxies/:id | `delete_proxy()` |
| GET /api/extensions | `get_extensions()` |
| DELETE /api/extensions/:id | `delete_extension()` |
| GET /api/profiles/:id/extensions | `get_profile_extensions()` |
| POST /api/profiles/:id/extensions | `set_profile_extensions()` |

## License

MIT — see [LICENSE](LICENSE).
