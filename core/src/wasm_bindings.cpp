#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#endif

#include "engine.hpp"
#include <string>

extern "C" {

#ifdef __EMSCRIPTEN__
EMSCRIPTEN_KEEPALIVE
#endif
void* anbang_create(const char* config) {
    auto* engine = new anbang::Engine(42);
    anbang::StateVector initial;
    engine->initialize(initial);
    return engine;
}

#ifdef __EMSCRIPTEN__
EMSCRIPTEN_KEEPALIVE
#endif
const char* anbang_step(void* ptr, int years) {
    auto* engine = static_cast<anbang::Engine*>(ptr);
    engine->step(years);
    static std::string result;
    result = engine->export_state_json();
    return result.c_str();
}

#ifdef __EMSCRIPTEN__
EMSCRIPTEN_KEEPALIVE
#endif
void anbang_intervene(void* ptr, const char* action, double intensity) {
    auto* engine = static_cast<anbang::Engine*>(ptr);
    engine->divine_intervention(std::string(action), intensity);
}

#ifdef __EMSCRIPTEN__
EMSCRIPTEN_KEEPALIVE
#endif
void anbang_destroy(void* ptr) {
    delete static_cast<anbang::Engine*>(ptr);
}

}