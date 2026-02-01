import type { AnbangWASM, StateVector } from "./types";

export class EngineBridge {
  private wasm: AnbangWASM;
  private enginePtr: number;

  constructor(wasm: AnbangWASM) {
    this.wasm = wasm;

    const config = JSON.stringify({
      initial_year: 0,
      population: 100000,
      carrying_capacity: 150000,
    });

    const configPtr = this.stringToPtr(config);
    this.enginePtr = wasm._anbang_create(configPtr);
    wasm._free(configPtr);
  }

  step(years: number = 1): StateVector {
    const resultPtr = this.wasm._anbang_step(this.enginePtr, years);
    const jsonStr = this.wasm.UTF8ToString(resultPtr);
    return JSON.parse(jsonStr) as StateVector;
  }

  intervene(action: string, intensity: number): void {
    const actionPtr = this.stringToPtr(action);
    this.wasm._anbang_intervene(this.enginePtr, actionPtr, intensity);
    this.wasm._free(actionPtr);
  }

  destroy(): void {
    this.wasm._anbang_destroy(this.enginePtr);
  }

  private stringToPtr(str: string): number {
    const bytes = new TextEncoder().encode(str + "\0");
    const ptr = this.wasm._malloc(bytes.length);
    this.wasm.HEAPU8.set(bytes, ptr);
    return ptr;
  }
}
