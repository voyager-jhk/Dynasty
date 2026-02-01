#!/bin/bash
set -e

echo "🧪 Running all tests..."

# C++ tests
echo ""
echo "Running C++ tests..."
cd core/build
ctest --output-on-failure
cd ../..
echo "✓ C++ tests passed"

# TypeScript type checking
echo ""
echo "Running TypeScript type check..."
cd frontend
pnpm type-check
cd ..
echo "✓ Type check passed"

# Python tests (if available)
if [ -f "calibration/.venv/bin/activate" ]; then
    echo ""
    echo "Running Python tests..."
    cd calibration
    source .venv/bin/activate
    pytest tests/ -v
    cd ..
    echo "✓ Python tests passed"
fi

echo ""
echo "✅ All tests passed!"