cmake_minimum_required(VERSION 3.20)
project(AnbangCore VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Options
option(BUILD_TESTS "Build tests" ON)
option(BUILD_WASM "Build for WebAssembly" OFF)

# Sources
file(GLOB_RECURSE SOURCES "src/*.cpp")
list(FILTER SOURCES EXCLUDE REGEX ".*wasm_bindings.cpp$")

# Main library
add_library(anbang_core STATIC ${SOURCES})
target_include_directories(anbang_core PUBLIC include)

# Compiler flags
if(NOT BUILD_WASM)
    target_compile_options(anbang_core PRIVATE
        -Wall -Wextra -Wpedantic
        -O3 -march=native
    )
endif()

# Tests
if(BUILD_TESTS AND NOT BUILD_WASM)
    enable_testing()
    add_subdirectory(tests)
endif()

# WASM target
if(BUILD_WASM)
    add_executable(anbang_wasm src/wasm_bindings.cpp)
    target_link_libraries(anbang_wasm anbang_core)
    
    set_target_properties(anbang_wasm PROPERTIES
        OUTPUT_NAME "anbang"
        SUFFIX ".js"
    )
endif()