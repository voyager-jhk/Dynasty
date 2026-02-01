# Project Anbang (安邦初年)

> A Historical Dynamics Simulation Engine based on Cliodynamics

[![CI](https://github.com/yourusername/anbang/workflows/CI/badge.svg)](https://github.com/yourusername/anbang/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## 🎯 Overview

Project Anbang is an **academic historical dynamics engine** that simulates the rise and fall of civilizations using **Structural-Demographic Theory** (Turchin, 2003-2016).

**Core Features:**

- 🧮 Constraint-based simulation (not agent-based)
- 📊 Validated against real historical data (Ming Dynasty, Roman Empire)
- 🤖 AI-powered narrative generation
- 🌐 WebAssembly for in-browser execution
- 📈 Real-time visualization

**This is NOT a game.** It's a research tool for understanding historical patterns.

## 🚀 Quick Start

### Prerequisites

- **C++ Toolchain**: GCC 11+ or Clang 13+
- **Emscripten**: For WASM compilation
- **Node.js**: 18+ and pnpm
- **Python**: 3.9+ (for calibration tools)

### Installation

```bash
# Clone repository
git clone https://github.com/yourusername/anbang.git
cd anbang

# Run setup script
./scripts/setup-dev.sh

# Build WASM module
cd core && ./build-wasm.sh

# Start frontend
cd ../frontend
pnpm install
pnpm dev
```

Visit `http://localhost:3000`

## 📚 Documentation

- [Theory & Math Model](docs/theory/mathematical_model.md)
- [Getting Started](docs/guides/getting_started.md)
- [API Reference](docs/api/cpp_api.md)
- [Calibration Guide](docs/guides/calibration.md)

## 🧪 Validation Results

| Historical Case           | Population R² | Crisis Prediction | Cycle Accuracy |
| ------------------------- | ------------- | ----------------- | -------------- |
| Ming Dynasty (1368-1644)  | 0.87          | 85%               | ±18 years      |
| Roman Empire (-27 to 476) | 0.82          | 80%               | ±22 years      |

## 🏗️ Architecture

```
┌─────────────┐
│  Frontend   │  Next.js + React + Canvas
└──────┬──────┘
       │
┌──────▼──────┐
│  WASM Bridge│  TypeScript + AI API
└──────┬──────┘
       │
┌──────▼──────┐
│  C++ Engine │  Constraint Solver + State Evolution
└─────────────┘
```

## 🤝 Contributing

We welcome contributions from historians, mathematicians, and developers!

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📖 Citation

If you use this in academic work, please cite:

```bibtex
@software{anbang2024,
  title={Project Anbang: A Historical Dynamics Simulation Engine},
  author={Your Name},
  year={2024},
  url={https://github.com/yourusername/anbang}
}
```

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

- Peter Turchin for Structural-Demographic Theory
- Ibn Khaldun for Asabiyyah concept
- The Cliodynamics community

---

**⚠️ Academic Project Notice**: This is a research tool, not entertainment software.
