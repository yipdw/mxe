/*
 * This file is part of MXE. See LICENSE.md for licensing information.
 */

#include <benchmark/benchmark.h>

BENCHMARK_F(SillyBenchmark)(benchmark::State& st)
{
    int x = 0;

    for (auto _ : st) {
        ++x;
        benchmark::ClobberMemory();
    }
}

BENCHMARK_MAIN();
