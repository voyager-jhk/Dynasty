#!/bin/bash
set -e

echo "⚡ Running performance benchmarks..."

# Build optimized version
cd core
mkdir -p build-benchmark
cd build-benchmark
cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF
cmake --build . -j$(nproc)

# Run benchmark
echo ""
echo "Benchmark: 1000 years simulation"
time ./anbang_benchmark 1000

echo ""
echo "Benchmark: 10000 years simulation"
time ./anbang_benchmark 10000

cd ../..