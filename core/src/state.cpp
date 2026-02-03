#include "state.hpp"
#include <sstream>
#include <iomanip>

namespace anbang {

StateVector::StateVector() 
    : N(100000), K(150000), E(2000), P(98000),
      MPI(0.67), EPI(1.0), FSI(1.0), PSI(0.5),
      A(0.7), I_gini(0.35),
      T(1.0), L_theo(0.0), O(0.0),
      year(0) {}

std::string StateVector::to_json() const {
    std::ostringstream oss;
    oss << std::fixed << std::setprecision(2);
    oss << "{"
        << "\"year\":" << year << ","
        << "\"population\":" << N << ","
        << "\"carrying_capacity\":" << K << ","
        << "\"elite_population\":" << E << ","
        << "\"real_wages\":" << 10.0 << ","
        << "\"MPI\":" << MPI << ","
        << "\"EPI\":" << EPI << ","
        << "\"FSI\":" << FSI << ","
        << "\"PSI\":" << PSI << ","
        << "\"asabiyyah\":" << A << ","
        << "\"tech_level\":" << T << ","
        << "\"theological_lock\":" << L_theo << ","
        << "\"observation\":" << O << ","
        << "\"phase\":\"expansion\","
        << "\"internal_war\":" << 0.0
        << "}";
    return oss.str();
}

} // namespace anbang