#!/bin/bash
set -e

echo "Building Anbang Core (Native)..."

# Create build directory
mkdir -p build
cd build

# Configure
cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=ON

# Build
cmake --build . -j$(nproc)

# Run tests
ctest --output-on-failure

echo "✓ Build complete. Binaries in build/"