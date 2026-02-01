# Getting Started with Project Anbang

## Prerequisites

- **C++ Compiler**: GCC 11+ or Clang 13+
- **CMake**: 3.20+
- **Emscripten**: Latest (for WASM)
- **Node.js**: 18+
- **pnpm**: 8+
- **Python**: 3.9+ (optional, for calibration)

## Quick Start

### 1. Clone and Setup

```bash
git clone https://github.com/yourusername/anbang.git
cd anbang
./scripts/setup-dev.sh
```

This will:

- Check all prerequisites
- Build C++ core
- Build WASM module
- Install frontend dependencies
- Setup Python environment

### 2. Configure Environment

```bash
cd frontend
cp .env.local.example .env.local
```

Edit `.env.local` and add your DeepSeek API key:

```
NEXT_PUBLIC_AI_API_KEY=your-api-key-here
```

### 3. Run Development Server

```bash
pnpm dev
```

Open http://localhost:3000

## Project Structure

```
anbang/
├── core/          # C++ engine (builds to WASM)
├── frontend/      # Next.js web app
├── calibration/   # Python tools
└── docs/          # Documentation
```

## Development Workflow

### Making Changes to C++ Code

```bash
cd core
# Edit files in src/ or include/
./build.sh          # Test locally
./build-wasm.sh     # Rebuild WASM for frontend
```

### Making Changes to Frontend

```bash
cd frontend
# Edit files in src/
pnpm dev            # Hot reload enabled
```

### Testing

```bash
./scripts/run-tests.sh
```

## Common Tasks

### Add Historical Data

1. Create CSV in `calibration/data/`
2. Add to calibration script
3. Run validation

### Modify Parameters

Edit `core/include/parameters.hpp`

### Add Constraints

Edit `core/src/constraints.cpp`

### Customize UI

Edit components in `frontend/src/components/`

## Troubleshooting

### WASM not loading

- Check `frontend/public/` has `anbang.wasm` and `anbang.js`
- Rebuild: `cd core && ./build-wasm.sh`

### Build errors

- Ensure CMake 3.20+
- Check compiler version
- Clear build: `rm -rf build build-wasm`

### Frontend errors

- Delete `node_modules` and `.next`
- Run `pnpm install` again

## Next Steps

- [Read the theory](../theory/mathematical_model.md)
- [Explore the API](../api/cpp_api.md)
- [Run calibration](../guides/calibration.md)
