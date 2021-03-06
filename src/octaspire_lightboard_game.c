#include <assert.h>
#include <stdbool.h>
#include "octaspire/lightboard/octaspire_lightboard_game.h"
#include "octaspire/lightboard/octaspire_lightboard_state.h"
#include <octaspire/core/octaspire_container_hash_map.h>
#include <octaspire/core/octaspire_container_vector.h>
#include <octaspire/core/octaspire_container_utf8_string.h>
#include <octaspire/core/octaspire_helpers.h>
#include "octaspire/lightboard/octaspire_lightboard_input.h"

struct octaspire_lightboard_game_t
{
    octaspire_memory_allocator_t   *allocator;
    octaspire_container_hash_map_t *animations;
    octaspire_container_vector_t   *states;
};

octaspire_lightboard_game_t *octaspire_lightboard_game_new(
    octaspire_memory_allocator_t * const allocator)
{
    octaspire_lightboard_game_t *self =
        octaspire_memory_allocator_malloc(allocator, sizeof(octaspire_lightboard_game_t));

    if (!self)
    {
        return self;
    }

    self->allocator = allocator;

    self->animations = octaspire_container_hash_map_new(
        sizeof(octaspire_container_utf8_string_t*),
        true,
        sizeof(octaspire_sdl2_animation_t*),
        true,
        (octaspire_container_hash_map_key_compare_function_t)octaspire_container_utf8_string_is_equal,
        (octaspire_container_hash_map_key_hash_function_t)octaspire_container_utf8_string_get_hash,
        (octaspire_container_hash_map_element_callback_function_t)octaspire_container_utf8_string_release,
        (octaspire_container_hash_map_element_callback_function_t)octaspire_sdl2_animation_release,
        allocator);

    if (!self->animations)
    {
        octaspire_lightboard_game_release(self);
        self = 0;
        return self;
    }

    self->states = octaspire_container_vector_new(
        sizeof(octaspire_lightboard_state_t*),
        true,
        (octaspire_container_vector_element_callback_t)octaspire_lightboard_state_release,
        allocator);

    if (!self->states)
    {
        octaspire_lightboard_game_release(self);
        self = 0;
        return self;
    }

    return self;
}

void octaspire_lightboard_game_release(octaspire_lightboard_game_t *self)
{
    if (!self)
    {
        return;
    }

    octaspire_container_hash_map_release(self->animations);
    octaspire_container_vector_release(self->states);
    octaspire_memory_allocator_free(self->allocator, self);
}

bool octaspire_lightboard_game_add_animation(
    octaspire_lightboard_game_t * const self,
    char const * const name,
    octaspire_sdl2_animation_t const * const animation)
{
    octaspire_container_utf8_string_t *key = octaspire_container_utf8_string_new(name, self->allocator);

    return octaspire_container_hash_map_put(
        self->animations,
        octaspire_container_utf8_string_get_hash(key),
        &key,
        &animation);
}

void octaspire_lightboard_game_update(
    octaspire_lightboard_game_t * const self,
    double const dt,
    octaspire_lightboard_input_t const input,
    int const mouseX,
    int const mouseY,

    int const origoX,
    int const origoY,

    int const winW,
    int const winH)
{
    if (!octaspire_container_vector_is_empty(self->states))
    {
        octaspire_lightboard_state_t *state = octaspire_container_vector_peek_back_element(self->states);
        octaspire_lightboard_state_update(state, dt, input, mouseX, mouseY, origoX, origoY, winW, winH);

        if (octaspire_lightboard_state_is_done(state))
        {
            octaspire_container_vector_pop_back_element(self->states);
        }
    }
}

void octaspire_lightboard_game_render(
    octaspire_lightboard_game_t const * const self,
    SDL_Renderer * const renderer,
    octaspire_sdl2_texture_t const * const texture,
    int const origoX,
    int const origoY)
{
    if (!octaspire_container_vector_is_empty(self->states))
    {
        octaspire_lightboard_state_t *state = octaspire_container_vector_peek_back_element(self->states);
        octaspire_lightboard_state_render(state, renderer, texture, origoX, origoY);
    }
}

octaspire_sdl2_animation_t *octaspire_lightboard_game_get_animation_copy(
    octaspire_lightboard_game_t const * const self,
    char const * const name)
{
    octaspire_container_utf8_string_t * tmpStr =
        octaspire_container_utf8_string_new(name, self->allocator);

    octaspire_container_hash_map_element_t const * const element =
        octaspire_container_hash_map_get_const(
            self->animations,
            octaspire_container_utf8_string_get_hash(tmpStr),
            &tmpStr);

    octaspire_container_utf8_string_release(tmpStr);
    tmpStr = 0;

    if (!element)
    {
        return 0;
    }

    octaspire_sdl2_animation_t const * const animation =
        octaspire_container_hash_map_element_get_value(element);

    assert(animation);

    return octaspire_sdl2_animation_new_copy(animation, self->allocator);
}

bool octaspire_lightboard_game_push_back_state(
    octaspire_lightboard_game_t * const self,
    octaspire_lightboard_state_t * const state)
{
    return octaspire_container_vector_push_back_element(self->states, &state);
}

octaspire_lightboard_state_t *octaspire_lightboard_game_get_current_state(
    octaspire_lightboard_game_t * const self)
{
    return octaspire_container_vector_peek_back_element(self->states);
}

