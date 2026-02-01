#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#endif

#include "engine.hpp"
#include <cstring>
#include <memory>

extern "C" {

#ifdef __EMSCRIPTEN__
EMSCRIPTEN_KEEPALIVE
#endif
void* anbang_create(const char* config_json) {
    auto* engine = new anbang::Engine(42);
    
    // Parse config and initialize
    anbang::StateVector initial;
    // TODO: Parse config_json
    
    engine->initialize(initial);
    return engine;
}

#ifdef __EMSCRIPTEN__
EMSCRIPTEN_KEEPALIVE
#endif
const char* anbang_step(void* engine_ptr, int years) {
    auto* engine = static_cast<anbang::Engine*>(engine_ptr);
    engine->step(years);
    
    static std::string json_result;
    json_result = engine->export_state_json();
    return json_result.c_str();
}

#ifdef __EMSCRIPTEN__
EMSCRIPTEN_KEEPALIVE
#endif
void anbang_intervene(void* engine_ptr, const char* action, double intensity) {
    auto* engine = static_cast<anbang::Engine*>(engine_ptr);
    engine->divine_intervention(std::string(action), intensity);
}

#ifdef __EMSCRIPTEN__
EMSCRIPTEN_KEEPALIVE
#endif
void anbang_destroy(void* engine_ptr) {
    delete static_cast<anbang::Engine*>(engine_ptr);
}

} // extern "C"