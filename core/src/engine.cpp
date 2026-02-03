#include "engine.hpp"
#include <cmath>
#include <algorithm>

namespace anbang {

Engine::Engine(unsigned seed) {
    state_ = StateVector();
}

void Engine::initialize(const StateVector& initial) {
    state_ = initial;
}

void Engine::step(int years) {
    for (int i = 0; i < years; i++) {
        state_.year++;
        
        double growth_rate = 0.02 * (1.0 - state_.N / state_.K);
        state_.N *= (1.0 + growth_rate);
        
        state_.E *= 1.03;
        state_.P = state_.N - state_.E;
        
        state_.MPI = state_.N / state_.K;
        state_.EPI = (state_.E / state_.N) / 0.02;
        state_.FSI = 1.0 + 0.5 * state_.MPI;
        state_.PSI = state_.MPI * state_.EPI * (1.0 - state_.A);
        
        state_.A *= 0.998;
       
        state_.T += 0.01 * (1.0 - state_.L_theo);
        
        state_.L_theo = 1.0 - std::exp(-0.01 * state_.O);
    }
}

void Engine::divine_intervention(const std::string& action, double intensity) {
    if (action == "climate_blessing") {
        state_.K *= (1.0 + 0.1 * intensity);
        state_.O += 5.0 * intensity;
    } else if (action == "grant_technology") {
        state_.T += 1.0 * intensity;
        state_.O += 30.0 * intensity;
    } else if (action == "smite_elites") {
        state_.E *= (1.0 - 0.5 * intensity);
        state_.O += 150.0 * intensity;
    } else if (action == "miracle_food") {
        state_.O += 300.0 * intensity;
    }
}

} // namespace anbang