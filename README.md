# Project Anbang

A constraint-based simulation engine built in C++20.

## Features

- **C++ Core Engine**: Constraint propagation system with 100+ state variables
- **Performance Optimized**: Sub-second execution for 1000-step simulations
- **WebAssembly**: Compiled with Emscripten for web deployment
- **Historical Validation**: Model validated against historical datasets (R² > 0.85)

## Architecture

```
core/          # C++20 engine with constraint solver
frontend/      # Next.js web interface
calibration/   # Python validation tools
```

## Build

```bash
# C++ core
cd core && mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make

# Frontend
cd frontend
pnpm install
pnpm dev
```

## Technical Highlights

- Constraint-based state evolution (not agent-based)
- Cache-friendly data structures for performance
- Deterministic simulation with reproducible results
- Modular architecture with pluggable components

## Status

🚧 Active development - WASM integration in progress
