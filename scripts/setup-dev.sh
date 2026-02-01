#!/bin/bash
set -e

echo "🚀 Setting up Project Anbang development environment..."

# Check prerequisites
echo "Checking prerequisites..."

# Check C++ compiler
if ! command -v g++ &> /dev/null && ! command -v clang++ &> /dev/null; then
    echo "❌ Error: No C++ compiler found. Install GCC or Clang."
    exit 1
fi
echo "✓ C++ compiler found"

# Check CMake
if ! command -v cmake &> /dev/null; then
    echo "❌ Error: CMake not found. Install from https://cmake.org"
    exit 1
fi
echo "✓ CMake found ($(cmake --version | head -n1))"

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Error: Node.js not found. Install from https://nodejs.org"
    exit 1
fi
echo "✓ Node.js found ($(node --version))"

# Check pnpm
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    npm install -g pnpm
fi
echo "✓ pnpm found ($(pnpm --version))"

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "⚠ Warning: Python 3 not found. Calibration tools will not work."
else
    echo "✓ Python found ($(python3 --version))"
fi

# Check Emscripten
if ! command -v emcc &> /dev/null; then
    echo "⚠ Warning: Emscripten not found. WASM build will not work."
    echo "  Install from: https://emscripten.org/docs/getting_started/downloads.html"
else
    echo "✓ Emscripten found ($(emcc --version | head -n1))"
fi

# Build C++ core
echo ""
echo "Building C++ core..."
cd core
./build.sh

# Build WASM (if Emscripten available)
if command -v emcc &> /dev/null; then
    echo ""
    echo "Building WASM module..."
    ./build-wasm.sh
fi

# Setup frontend
echo ""
echo "Setting up frontend..."
cd ../frontend
pnpm install

# Setup calibration tools
echo ""
echo "Setting up calibration tools..."
cd ../calibration
if command -v python3 &> /dev/null; then
    python3 -m venv .venv
    source .venv/bin/activate
    pip install -r requirements.txt
    echo "✓ Python environment created (.venv)"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Copy frontend/.env.local.example to frontend/.env.local"
echo "  2. Add your DeepSeek API key"
echo "  3. Run: cd frontend && pnpm dev"
echo ""