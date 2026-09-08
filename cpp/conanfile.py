import os
from conan import ConanFile
from conan.tools.files import copy, save
from conan.tools.cmake import CMake

class AntybrowserConan(ConanFile):
    name = "antybrowser"
    version = "1.0.3"
    license = "MIT"
    description = "Official Antybrowser SDK - C++ client for the Antybrowser Local API"
    url = "https://github.com/antybrowser/SDK"
    exports_sources = "include/*"
    no_copy_source = True

    def package(self):
        copy(self, "*.hpp", dst=os.path.join(self.package_folder, "include"),
             src=os.path.join(self.source_folder, "include"))

    def package_id(self):
        self.info.clear()

    def package_info(self):
        self.cpp_info.includedirs = ["include"]
        self.cpp_info.bindirs = []
        self.cpp_info.libdirs = []
