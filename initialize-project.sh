#!/bin/bash
set -e

PROJECT_NAME="anbang"
echo "🚀 Initializing Project Anbang..."
echo ""

# 创建根目录
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME

# ============================================
# 1. 创建根目录文件
# ============================================

echo "📁 Creating root structure..."

cat > README.md << 'EOF'
# Project Anbang (安邦初年)

> A Historical Dynamics Simulation Engine based on Cliodynamics

## Quick Start

```bash
./scripts/setup-dev.sh
cd frontend && pnpm dev
```

Visit http://localhost:3000

## Documentation

- [Getting Started](docs/guides/getting_started.md)
- [Deployment Guide](docs/guides/deployment.md)
- [Theory](docs/theory/mathematical_model.md)

## License

MIT - see LICENSE file
EOF

cat > .gitignore << 'EOF'
# Build
/core/build/
/core/build-wasm/
*.wasm
*.js.mem
/frontend/.next/
/frontend/out/

# Dependencies
node_modules/
__pycache__/
.venv/

# IDE
.vscode/
.idea/
.DS_Store

# Env
.env
.env.local

# Logs
*.log
EOF

cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2024 Your Name

Permission is hereby granted, free of charge...
(完整的 MIT 许可证文本)
EOF

# ============================================
# 2. 创建 C++ 核心结构
# ============================================

echo "🔧 Creating C++ core structure..."

mkdir -p core/{include,src,tests}

cat > core/CMakeLists.txt << 'EOF'
cmake_minimum_required(VERSION 3.20)
project(AnbangCore VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(BUILD_TESTS "Build tests" ON)
option(BUILD_WASM "Build for WebAssembly" OFF)

file(GLOB_RECURSE SOURCES "src/*.cpp")
list(FILTER SOURCES EXCLUDE REGEX ".*wasm_bindings.cpp$")

add_library(anbang_core STATIC ${SOURCES})
target_include_directories(anbang_core PUBLIC include)

if(NOT BUILD_WASM)
    target_compile_options(anbang_core PRIVATE -Wall -Wextra -O3)
endif()

if(BUILD_TESTS AND NOT BUILD_WASM)
    enable_testing()
    add_subdirectory(tests)
endif()
EOF

cat > core/build.sh << 'EOF'
#!/bin/bash
set -e
echo "Building Anbang Core..."
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . -j$(nproc)
ctest --output-on-failure
echo "✓ Build complete"
EOF
chmod +x core/build.sh

cat > core/build-wasm.sh << 'EOF'
#!/bin/bash
set -e
echo "Building WASM..."

if ! command -v emcc &> /dev/null; then
    echo "Error: Emscripten not found"
    exit 1
fi

mkdir -p build-wasm && cd build-wasm
emcmake cmake .. -DBUILD_WASM=ON -DBUILD_TESTS=OFF
emmake make -j$(nproc)

emcc ../src/wasm_bindings.cpp \
    -I../include libanbang_core.a \
    -O3 -s WASM=1 \
    -s EXPORTED_FUNCTIONS='["_anbang_create","_anbang_step","_anbang_intervene","_anbang_destroy"]' \
    -s EXPORTED_RUNTIME_METHODS='["UTF8ToString"]' \
    -s ALLOW_MEMORY_GROWTH=1 \
    -s MODULARIZE=1 \
    -s EXPORT_NAME='createAnbangModule' \
    -o anbang.js

cp anbang.{wasm,js} ../../frontend/public/
echo "✓ WASM built and copied to frontend"
EOF
chmod +x core/build-wasm.sh

# 创建头文件骨架
cat > core/include/state.hpp << 'EOF'
#pragma once
#include <string>

namespace anbang {

struct StateVector {
    double N, K, E, P;
    double MPI, EPI, FSI, PSI;
    double A, I_gini;
    double T, L_theo, O;
    int year;
    
    StateVector();
    std::string to_json() const;
};

} // namespace anbang
EOF

cat > core/include/engine.hpp << 'EOF'
#pragma once
#include "state.hpp"
#include <vector>
#include <string>

namespace anbang {

class Engine {
public:
    explicit Engine(unsigned seed = 42);
    void initialize(const StateVector& initial);
    void step(int years = 1);
    void divine_intervention(const std::string& action, double intensity);
    const StateVector& get_state() const;
    std::string export_state_json() const;

private:
    StateVector state_;
};

} // namespace anbang
EOF

# 创建源文件骨架
cat > core/src/state.cpp << 'EOF'
#include "state.hpp"
#include <sstream>

namespace anbang {

StateVector::StateVector() 
    : N(100000), K(150000), E(2000), P(98000),
      MPI(0), EPI(0), FSI(0), PSI(0),
      A(0.7), I_gini(0.35),
      T(1.0), L_theo(0.0), O(0.0),
      year(0) {}

std::string StateVector::to_json() const {
    std::ostringstream oss;
    oss << "{"
        << "\"year\":" << year << ","
        << "\"population\":" << N << ","
        << "\"PSI\":" << PSI
        << "}";
    return oss.str();
}

} // namespace anbang
EOF

cat > core/src/engine.cpp << 'EOF'
#include "engine.hpp"

namespace anbang {

Engine::Engine(unsigned seed) {}

void Engine::initialize(const StateVector& initial) {
    state_ = initial;
}

void Engine::step(int years) {
    for (int i = 0; i < years; i++) {
        state_.year++;
        // TODO: 实现演化逻辑
    }
}

void Engine::divine_intervention(const std::string& action, double intensity) {
    // TODO: 实现干预逻辑
}

const StateVector& Engine::get_state() const {
    return state_;
}

std::string Engine::export_state_json() const {
    return state_.to_json();
}

} // namespace anbang
EOF

cat > core/src/wasm_bindings.cpp << 'EOF'
#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#endif
#include "engine.hpp"

extern "C" {

void* anbang_create(const char* config) {
    auto* engine = new anbang::Engine(42);
    anbang::StateVector initial;
    engine->initialize(initial);
    return engine;
}

const char* anbang_step(void* ptr, int years) {
    auto* engine = static_cast<anbang::Engine*>(ptr);
    engine->step(years);
    static std::string result;
    result = engine->export_state_json();
    return result.c_str();
}

void anbang_intervene(void* ptr, const char* action, double intensity) {
    auto* engine = static_cast<anbang::Engine*>(ptr);
    engine->divine_intervention(action, intensity);
}

void anbang_destroy(void* ptr) {
    delete static_cast<anbang::Engine*>(ptr);
}

}
EOF

# ============================================
# 3. 创建前端结构
# ============================================

echo "🎨 Creating frontend structure..."

mkdir -p frontend/{src/{app,components,lib,hooks},public}

cat > frontend/package.json << 'EOF'
{
  "name": "anbang-frontend",
  "version": "0.1.0",
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start"
  },
  "dependencies": {
    "next": "14.2.0",
    "react": "^18.3.0",
    "react-dom": "^18.3.0",
    "lucide-react": "^0.263.1",
    "zustand": "^4.5.0"
  },
  "devDependencies": {
    "@types/node": "^20",
    "@types/react": "^18",
    "typescript": "^5",
    "tailwindcss": "^3.4.0"
  }
}
EOF

cat > frontend/tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["dom", "esnext"],
    "jsx": "preserve",
    "module": "esnext",
    "strict": true,
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
EOF

cat > frontend/next.config.js << 'EOF'
module.exports = {
  reactStrictMode: true,
  webpack: (config) => {
    config.experiments = { asyncWebAssembly: true };
    return config;
  },
};
EOF

cat > frontend/tailwind.config.js << 'EOF'
module.exports = {
  content: ['./src/**/*.{js,ts,jsx,tsx}'],
  theme: { extend: {} },
  plugins: [],
};
EOF

cat > frontend/.env.local.example << 'EOF'
NEXT_PUBLIC_AI_API_KEY=your-api-key-here
NEXT_PUBLIC_AI_BASE_URL=https://api.deepseek.com
NEXT_PUBLIC_AI_MODEL=deepseek-chat
EOF

cat > frontend/src/app/layout.tsx << 'EOF'
import './globals.css';

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return <html lang="en"><body>{children}</body></html>;
}
EOF

cat > frontend/src/app/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  background: black;
  color: white;
  font-family: monospace;
}
EOF

cat > frontend/src/app/page.tsx << 'EOF'
export default function Home() {
  return (
    <div className="p-8">
      <h1 className="text-2xl">Project Anbang</h1>
      <p className="mt-4">Historical Dynamics Engine</p>
      <p className="mt-2 text-gray-500">Run setup script to build WASM module</p>
    </div>
  );
}
EOF

# ============================================
# 4. 创建工具脚本
# ============================================

echo "🛠️  Creating utility scripts..."

mkdir -p scripts

cat > scripts/setup-dev.sh << 'EOF'
#!/bin/bash
set -e
echo "🚀 Setting up development environment..."

# Check prerequisites
command -v cmake >/dev/null || { echo "❌ CMake not found"; exit 1; }
command -v node >/dev/null || { echo "❌ Node.js not found"; exit 1; }

echo "✓ Prerequisites OK"

# Build C++
echo "Building C++ core..."
cd core && ./build.sh && cd ..

# Build WASM (if emcc available)
if command -v emcc >/dev/null; then
    echo "Building WASM..."
    cd core && ./build-wasm.sh && cd ..
else
    echo "⚠️  Emscripten not found, skipping WASM build"
fi

# Setup frontend
echo "Installing frontend dependencies..."
cd frontend
npm install -g pnpm 2>/dev/null || true
pnpm install
cd ..

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. cd frontend"
echo "  2. cp .env.local.example .env.local"
echo "  3. Edit .env.local with your API key"
echo "  4. pnpm dev"
EOF
chmod +x scripts/setup-dev.sh

# ============================================
# 5. 创建文档
# ============================================

echo "📚 Creating documentation..."

mkdir -p docs/{theory,api,guides}

cat > docs/guides/getting_started.md << 'EOF'
# Getting Started

## Installation

```bash
./scripts/setup-dev.sh
```

## Running

```bash
cd frontend
pnpm dev
```

Open http://localhost:3000
EOF

cat > docs/guides/deployment.md << 'EOF'
# Deployment Guide

## Vercel

```bash
cd frontend
vercel
```

## Docker

```bash
docker-compose up -d
```
EOF

# ============================================
# 6. 创建 GitHub 配置
# ============================================

echo "⚙️  Creating GitHub configuration..."

mkdir -p .github/workflows

cat > .github/workflows/ci.yml << 'EOF'
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Build C++
        run: cd core && ./build.sh
      - name: Test Frontend
        run: cd frontend && npm install && npm run build
EOF

# ============================================
# 完成
# ============================================

echo ""
echo "✅ Project structure created successfully!"
echo ""
echo "📂 Project structure:"
tree -L 2 -I 'node_modules|build*' . || ls -R
echo ""
echo "🚀 Next steps:"
echo "  1. cd $PROJECT_NAME"
echo "  2. ./scripts/setup-dev.sh"
echo "  3. cd frontend && pnpm dev"
echo ""
echo "📖 Read docs/guides/getting_started.md for more info"