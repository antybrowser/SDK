cmake_minimum_required(VERSION 3.14)
project(antybrowser VERSION 1.0.3 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(antybrowser INTERFACE)
target_include_directories(antybrowser INTERFACE include/)

find_package(CURL REQUIRED)
target_link_libraries(antybrowser INTERFACE CURL::libcurl)
