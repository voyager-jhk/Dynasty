import type { AnbangWASM } from "./types";

let wasmModule: AnbangWASM | null = null;

export async function loadWASM(): Promise<AnbangWASM> {
  if (wasmModule) return wasmModule;

  try {
    // @ts-ignore - WASM module
    const createModule = (await import("../../public/anbang.js")).default;

    wasmModule = await createModule({
      locateFile: (path: string) => {
        if (path.endsWith(".wasm")) {
          return "/anbang.wasm";
        }
        return path;
      },
    });

    console.log("✓ WASM module loaded successfully");
    return wasmModule;
  } catch (error) {
    console.error("Failed to load WASM module:", error);
    throw error;
  }
}
