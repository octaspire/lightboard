#ifndef OCTASPIRE_LIGHTBOARD_STATE_H
#define OCTASPIRE_LIGHTBOARD_STATE_H

#include <stdbool.h>
#include <stddef.h>
#include "SDL.h"
#include <octaspire/core/octaspire_memory.h>
#include <octaspire/core/octaspire_stdio.h>
#include <octaspire/sdl2-utils/octaspire_sdl2_texture.h>
#include "octaspire/lightboard/octaspire_lightboard_input.h"

#ifdef __cplusplus
extern "C" {
#endif

struct octaspire_lightboard_game_t;

typedef struct octaspire_lightboard_state_t octaspire_lightboard_state_t;

octaspire_lightboard_state_t *octaspire_lightboard_state_new(
    struct octaspire_lightboard_game_t *parent,
    char const * const scriptBuffer,
    size_t const scriptBufferLengthInOctets,
    octaspire_memory_allocator_t * const allocator,
    octaspire_stdio_t * const stdio);

void octaspire_lightboard_state_release(octaspire_lightboard_state_t *self);

void octaspire_lightboard_state_update(
    octaspire_lightboard_state_t * const self,
    double const dt,
    octaspire_lightboard_input_t const input,
    int const mouseX,
    int const mouseY,
    int const origoX,
    int const origoY,
    int const winW,
    int const winH);

void octaspire_lightboard_state_render(
    octaspire_lightboard_state_t const * const self,
    SDL_Renderer * const renderer,
    octaspire_sdl2_texture_t const * const texture,
    int const origoX,
    int const origoY);

struct octaspire_lightboard_game_t *octaspire_lightboard_state_get_parent(
    octaspire_lightboard_state_t * const self);

bool octaspire_lightboard_state_is_done(
    octaspire_lightboard_state_t const * const self);

bool octaspire_lightboard_state_add_named_animation_of_type_to_position(
    octaspire_lightboard_state_t * const self,
    char const * const name,
    char const * const type,
    int const x,
    int const y,
    int const z);

bool octaspire_lightboard_state_remove_all_animations(
    octaspire_lightboard_state_t * const self);

bool octaspire_lightboard_state_set_animation_position(
    octaspire_lightboard_state_t * const self,
    char const * const name,
    int const x,
    int const y,
    int const z);

bool octaspire_lightboard_state_remove_named_animation(
    octaspire_lightboard_state_t * const self,
    char const * const name);

bool octaspire_lightboard_state_is_named_animation_visible(
    octaspire_lightboard_state_t const * const self,
    char const * const name);

void octaspire_lightboard_state_set_named_animation_visible(
    octaspire_lightboard_state_t const * const self,
    char const * const name,
    bool const visible);

bool octaspire_lightboard_state_tween_level_out(
    octaspire_lightboard_state_t * const self);


#ifdef __cplusplus
}
#endif

#endif

