from conan import ConanFile


class AntybrowserConan(ConanFile):
    name = "antybrowser"
    version = "1.0.3"
    license = "MIT"
    description = "Official Antybrowser SDK — C++ client for the Antybrowser Local API"
    url = "https://github.com/antybrowser/SDK"
    requires = "curl/8.0.0", "nlohmann_json/3.11.2"
    exports_sources = "include/*"

    def package(self):
        self.copy("*.hpp", dst="include", src="include")
