export interface StateVector {
  year: number;
  population: number;
  carrying_capacity: number;
  elite_population: number;
  real_wages: number;
  MPI: number;
  EPI: number;
  FSI: number;
  PSI: number;
  asabiyyah: number;
  tech_level: number;
  theological_lock: number;
  observation: number;
  phase: "expansion" | "stagflation" | "crisis" | "recovery";
  internal_war: number;
}

export interface HistoricalEvent {
  year: number;
  type: string;
  intensity: number;
  cause: string;
  narrative?: string;
}

export interface AnbangWASM {
  _anbang_create: (configPtr: number) => number;
  _anbang_step: (enginePtr: number, years: number) => number;
  _anbang_intervene: (
    enginePtr: number,
    actionPtr: number,
    intensity: number,
  ) => void;
  _anbang_destroy: (enginePtr: number) => void;
  _malloc: (size: number) => number;
  _free: (ptr: number) => void;
  HEAPU8: Uint8Array;
  UTF8ToString: (ptr: number) => string;
  stringToUTF8: (str: string, ptr: number, maxBytes: number) => void;
}
