#ifndef OCTASPIRE_LIGHTBOARD_GAME_H
#define OCTASPIRE_LIGHTBOARD_GAME_H

#include <stdbool.h>
#include <octaspire/sdl2-utils/octaspire_sdl2_animation.h>
#include "octaspire/lightboard/octaspire_lightboard_state.h"
#include "octaspire/lightboard/octaspire_lightboard_input.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct octaspire_lightboard_game_t octaspire_lightboard_game_t;

octaspire_lightboard_game_t *octaspire_lightboard_game_new(
    octaspire_memory_allocator_t * const allocator);

void octaspire_lightboard_game_release(octaspire_lightboard_game_t *self);

bool octaspire_lightboard_game_add_animation(
    octaspire_lightboard_game_t * const self,
    char const * const name,
    octaspire_sdl2_animation_t const * const animation);

void octaspire_lightboard_game_update(
    octaspire_lightboard_game_t * const self,
    double const dt,
    octaspire_lightboard_input_t const intput,
    int const mouseX,
    int const mouseY,
    int const origoX,
    int const origoY,
    int const winW,
    int const winH);

void octaspire_lightboard_game_render(
    octaspire_lightboard_game_t const * const self,
    SDL_Renderer * const renderer,
    octaspire_sdl2_texture_t const * const texture,
    int const origoX,
    int const origoY);

octaspire_sdl2_animation_t *octaspire_lightboard_game_get_animation_copy(
    octaspire_lightboard_game_t const * const self,
    char const * const name);

bool octaspire_lightboard_game_push_back_state(
    octaspire_lightboard_game_t * const self,
    octaspire_lightboard_state_t * const state);

octaspire_lightboard_state_t *octaspire_lightboard_game_get_current_state(
    octaspire_lightboard_game_t * const self);

#ifdef __cplusplus
}
#endif

#endif

