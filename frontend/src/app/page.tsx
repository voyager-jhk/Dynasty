"use client";
import { useState, useEffect } from "react";

export default function Home() {
  const [year, setYear] = useState(0);
  const [running, setRunning] = useState(false);
  const [state, setState] = useState({
    population: 100000,
    PSI: 0.5,
    asabiyyah: 0.7,
  });

  useEffect(() => {
    if (!running) return;
    const timer = setInterval(() => {
      setYear((y) => y + 1);
      setState((s) => ({
        population: s.population * 1.02,
        PSI: Math.min(5, s.PSI + Math.random() * 0.1),
        asabiyyah: Math.max(0, s.asabiyyah - 0.002),
      }));
    }, 100);
    return () => clearInterval(timer);
  }, [running]);

  return (
    <div className="flex h-screen bg-black text-white font-mono">
      <div className="w-80 border-r border-gray-700 p-4">
        <h1 className="text-xl mb-8">PROJECT ANBANG</h1>
        <div className="space-y-4">
          <div>
            <div className="text-gray-500 text-xs">YEAR</div>
            <div className="text-3xl tabular-nums">{year}</div>
          </div>
          <div>
            <div className="text-gray-500 text-xs">POPULATION</div>
            <div className="text-xl">
              {Math.floor(state.population).toLocaleString()}
            </div>
          </div>
          <div>
            <div className="text-gray-500 text-xs">PSI (Political Stress)</div>
            <div
              className={`text-xl ${state.PSI > 3 ? "text-red-500" : "text-green-500"}`}
            >
              {state.PSI.toFixed(2)}
            </div>
          </div>
          <div>
            <div className="text-gray-500 text-xs">ASABIYYAH</div>
            <div className="text-xl">{(state.asabiyyah * 100).toFixed(0)}%</div>
          </div>
        </div>
        <button
          onClick={() => setRunning(!running)}
          className="mt-8 w-full px-4 py-2 border border-white hover:bg-white hover:text-black"
        >
          {running ? "PAUSE" : "START"}
        </button>
      </div>
      <div className="flex-1 flex items-center justify-center">
        <div className="text-center text-gray-600">
          <div className="text-sm">C++ Constraint-Based Engine</div>
          <div className="text-xs mt-2">
            Frontend Demo - Full WASM integration in progress
          </div>
        </div>
      </div>
    </div>
  );
}
