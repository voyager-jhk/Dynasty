"use client";

import { useState, useEffect, useRef } from "react";
import { loadWASM } from "@/lib/wasm-loader";
import { EngineBridge } from "@/lib/engine-bridge";
import type { StateVector } from "@/lib/types";

export function useSimulation() {
  const [isReady, setIsReady] = useState(false);
  const [isRunning, setIsRunning] = useState(false);
  const [speed, setSpeed] = useState(1);
  const [state, setState] = useState<StateVector | null>(null);
  const [history, setHistory] = useState<StateVector[]>([]);

  const engineRef = useRef<EngineBridge | null>(null);
  const intervalRef = useRef<number>();

  // Initialize engine
  useEffect(() => {
    let cleanup: (() => void) | null = null;

    (async () => {
      try {
        const wasm = await loadWASM();
        const engine = new EngineBridge(wasm);
        engineRef.current = engine;

        const initialState = engine.step(0);
        setState(initialState);
        setHistory([initialState]);
        setIsReady(true);

        cleanup = () => engine.destroy();
      } catch (error) {
        console.error("Failed to initialize engine:", error);
      }
    })();

    return () => {
      if (cleanup) cleanup();
    };
  }, []);

  // Simulation loop
  useEffect(() => {
    if (!isRunning || !engineRef.current) return;

    intervalRef.current = window.setInterval(() => {
      const newState = engineRef.current!.step(1);
      setState(newState);
      setHistory((h) => [...h.slice(-100), newState]);
    }, 1000 / speed);

    return () => clearInterval(intervalRef.current);
  }, [isRunning, speed]);

  const start = () => setIsRunning(true);
  const pause = () => setIsRunning(false);
  const reset = () => {
    if (engineRef.current) {
      const initialState = engineRef.current.step(0);
      setState(initialState);
      setHistory([initialState]);
    }
  };

  const intervene = (action: string, intensity: number) => {
    if (engineRef.current) {
      engineRef.current.intervene(action, intensity);
    }
  };

  return {
    isReady,
    isRunning,
    speed,
    state,
    history,
    start,
    pause,
    reset,
    setSpeed,
    intervene,
  };
}
