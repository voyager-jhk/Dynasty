#!/bin/bash
set -e

echo "Building Anbang Core (WebAssembly)..."

# Check if Emscripten is available
if ! command -v emcc &> /dev/null; then
    echo "Error: Emscripten not found. Install from https://emscripten.org"
    exit 1
fi

# Create build directory
mkdir -p build-wasm
cd build-wasm

# Configure with Emscripten
emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_WASM=ON \
    -DBUILD_TESTS=OFF

# Build
emmake make -j$(nproc)

# Additional Emscripten flags for the final link
emcc ../src/wasm_bindings.cpp \
    -I../include \
    libanbang_core.a \
    -O3 \
    -s WASM=1 \
    -s EXPORTED_FUNCTIONS='["_anbang_create","_anbang_step","_anbang_intervene","_anbang_destroy","_malloc","_free"]' \
    -s EXPORTED_RUNTIME_METHODS='["UTF8ToString","stringToUTF8"]' \
    -s ALLOW_MEMORY_GROWTH=1 \
    -s MAXIMUM_MEMORY=512MB \
    -s MODULARIZE=1 \
    -s EXPORT_NAME='createAnbangModule' \
    -o anbang.js

# Copy to frontend
echo "Copying WASM files to frontend..."
cp anbang.wasm ../../frontend/public/
cp anbang.js ../../frontend/public/

echo "✓ WASM build complete."
echo "  - anbang.wasm: $(du -h anbang.wasm | cut -f1)"
echo "  - Files copied to frontend/public/"
