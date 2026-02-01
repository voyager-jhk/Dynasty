#pragma once
#include <string>

namespace anbang {

/**
 * @brief Complete state vector of a civilization
 * Based on Structural-Demographic Theory (Turchin, 2003-2016)
 */
struct StateVector {
    // === Demographics ===
    double N;                      // Total population
    double K;                      // Carrying capacity
    double E;                      // Elite population
    double P;                      // Commoner population
    
    // === Economics ===
    double w;                      // Real wages
    double Y;                      // Total output
    double R;                      // State revenue
    double tau;                    // Tax rate [0,1]
    double grain_reserves;
    
    // === Core Indices ===
    double MPI;                    // Malthusian Pressure Index
    double EPI;                    // Elite Overproduction Index
    double FSI;                    // Fiscal Stress Index
    double PSI;                    // Political Stress Index
    
    // === Social Cohesion (Asabiyyah) ===
    double A;                      // Cohesion [0,1]
    double I_gini;                 // Inequality (Gini)
    
    // === Technology & Culture ===
    double T;                      // Tech level
    double L_theo;                 // Theological lock [0,1]
    double O;                      // Observation metric
    
    // === External Pressure ===
    double P_mil;                  // Military pressure
    double C_climate;              // Climate suitability
    
    // === Conflict States ===
    double internal_war;
    double famine_intensity;
    double plague_intensity;
    
    // === Time ===
    int year;
    
    // === Phase ===
    enum class Phase {
        EXPANSION,
        STAGFLATION,
        CRISIS,
        RECOVERY
    } cycle_phase;
    
    StateVector();
    
    // Serialization
    std::string to_json() const;
    static StateVector from_json(const std::string& json);
};

} // namespace anbang
