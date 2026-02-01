#pragma once

namespace anbang {

/**
 * @brief Calibrated parameters for historical dynamics
 * Sources: Turchin (2003, 2009, 2016), Ibn Khaldun (1377)
 */
struct Parameters {
    // Population dynamics
    double r = 0.02;               // Intrinsic growth rate
    double mu_0 = 0.025;           // Base mortality
    double alpha_tech = 0.3;       // Tech elasticity on K
    double beta_climate = 0.4;     // Climate elasticity on K
    
    // Elite dynamics
    double r_E = 0.03;             // Elite growth rate
    double e_star = 0.02;          // Equilibrium elite ratio
    double EPI_crit = 2.0;         // Elite crisis threshold
    
    // Wages (Ricardo-Malthus)
    double w_subsistence = 5.0;
    double eta_wage = 0.5;         // Wage elasticity
    
    // Fiscal
    double tau_optimal = 0.35;     // Optimal tax rate
    double c_admin = 0.8;          // Admin cost exponent
    double c_military = 1.0;
    
    // Asabiyyah (Ibn Khaldun)
    double lambda_decay = 0.002;   // Natural decay rate
    double gamma_inequality = 0.5; // Inequality erosion
    double A_crit = 0.3;           // Collapse threshold
    
    // Theological lock
    double k_theo = 0.01;          // Observation conversion
    
    // Climate
    double sigma_climate = 0.05;   // Annual volatility
    
    // PSI thresholds
    double PSI_stable = 1.0;
    double PSI_turbulent = 3.0;
    double PSI_crisis = 5.0;
};

} // namespace anbang
