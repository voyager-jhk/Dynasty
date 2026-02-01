#!/bin/bash
set -e

echo "🚀 Deploying to Vercel..."

# Build WASM
echo "Building WASM module..."
cd core
./build-wasm.sh
cd ..

# Deploy frontend
echo "Deploying frontend..."
cd frontend
vercel --prod
cd ..

echo "✅ Deployment complete!"