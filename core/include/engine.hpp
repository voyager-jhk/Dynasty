#pragma once
#include "state.hpp"
#include "parameters.hpp"
#include <vector>
#include <string>
#include <random>

namespace anbang {

/**
 * @brief Main simulation engine
 */
class Engine {
public:
    explicit Engine(unsigned seed = 42);
    
    void initialize(const StateVector& initial);
    void step(int years = 1);
    
    void divine_intervention(const std::string& action, double intensity);
    
    const StateVector& get_state() const { return state_; }
    const std::vector<std::string>& get_events() const { return events_; }
    
    std::string export_state_json() const;
    
private:
    StateVector state_;
    Parameters params_;
    std::vector<std::string> events_;
    std::mt19937 rng_;
    
    void apply_population_dynamics();
    void apply_elite_dynamics();
    void apply_economic_dynamics();
    void apply_asabiyyah_dynamics();
    void apply_tech_dynamics();
    void apply_climate_shock();
    void calculate_indices();
    void detect_crises();
};

} // namespace anbang