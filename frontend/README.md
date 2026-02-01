# Anbang Frontend

Next.js 14 application with WebAssembly integration.

## Development

```bash
# Install dependencies
pnpm install

# Run dev server
pnpm dev

# Build for production
pnpm build

# Type check
pnpm type-check
```

## Environment Variables

Copy `.env.local.example` to `.env.local` and fill in:

- `NEXT_PUBLIC_AI_API_KEY`: DeepSeek API key
- `NEXT_PUBLIC_AI_BASE_URL`: API endpoint
- `NEXT_PUBLIC_AI_MODEL`: Model name

## WASM Integration

WASM files should be in `public/`:

- `anbang.wasm` - Compiled engine
- `anbang.js` - Glue code

Build with: `cd ../core && ./build-wasm.sh`

## Components

- `Dashboard` - Metrics display
- `Timeline` - Time control
- `ChartCanvas` - Real-time plotting
- `GodPanel` - Intervention controls
- `Chronicle` - AI-generated narrative

## Hooks

- `useSimulation` - Main simulation state
- `useNarrative` - AI narrative generation

## Performance

Target: 60fps at 10x speed

- Use Canvas for charts (not SVG)
- Throttle updates to 16ms
- Lazy load AI narrative
