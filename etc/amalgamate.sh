#!/usr/bin/env sh

FILE="$1/octaspire_lightboard_amalgamated.c"

# Remove old file, if created
rm -rf $FILE

# Write license and the top-part of the include guards
cat >> $FILE << EnDoFmEsSaGe
/******************************************************************************
Octaspire Lightboard - Puzzle game
Copyright 2017 www.octaspire.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*******************************************************************************

  This file is amalgamated version of the header files and implementation files
  of Octaspire Lightboard. It is created automatically by a script.

                            DO NOT EDIT MANUALLY!

  Edit the separate .h and .c files in the source distribution and then
  let the script create this file agian with the modifications.

******************************************************************************/
#ifndef OCTASPIRE_LIGHTBOARD_AMALGAMATED_H
#define OCTASPIRE_LIGHTBOARD_AMALGAMATED_H

EnDoFmEsSaGe


# Write system includes
cat >> $FILE << EnDoFmEsSaGe
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include <string.h>
#include <inttypes.h>
#include <ctype.h>
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <stdarg.h>
#include <limits.h>
#include <wchar.h>

#include "SDL.h"




EnDoFmEsSaGe





concat_file() {
INFILE=$1
cat >> $FILE << EnDoFmEsSaGe
//////////////////////////////////////////////////////////////////////////////////////////////////
// START OF        $INFILE
//////////////////////////////////////////////////////////////////////////////////////////////////
EnDoFmEsSaGe
sed -n '/#include/!p' $INFILE >> $FILE
cat >> $FILE << EnDoFmEsSaGe
//////////////////////////////////////////////////////////////////////////////////////////////////
// END OF          $INFILE
//////////////////////////////////////////////////////////////////////////////////////////////////



EnDoFmEsSaGe
}





concat_config_file() {
INFILE=$1
cat >> $FILE << EnDoFmEsSaGe
//////////////////////////////////////////////////////////////////////////////////////////////////
// START OF        $INFILE
//////////////////////////////////////////////////////////////////////////////////////////////////
EnDoFmEsSaGe
cat $INFILE >> $FILE
sed -i '/#define OCTASPIRE_DERN_CONFIG_TEST_RES_PATH/d'  $FILE
sed -i '/#define OCTASPIRE_LIGHTBOARD_CONFIG_TEST_RES_PATH/d'  $FILE
sed -i '/#define OCTASPIRE_DERN_CONFIG_BINARY_PLUGINS/d' $FILE
cat >> $FILE << EnDoFmEsSaGe
//////////////////////////////////////////////////////////////////////////////////////////////////
// END OF          $INFILE
//////////////////////////////////////////////////////////////////////////////////////////////////



EnDoFmEsSaGe
}


concat_lightboard_main_file() {
INFILE=$1
cat >> $FILE << EnDoFmEsSaGe
//////////////////////////////////////////////////////////////////////////////////////////////////
// START OF        $INFILE
//////////////////////////////////////////////////////////////////////////////////////////////////
EnDoFmEsSaGe
sed -n '/#include/!p' $INFILE >> $FILE
sed -i '/extern char   const octaspire_lightboard_ini/d'                  $FILE
sed -i '/extern size_t const octaspire_lightboard_ini_len/d'              $FILE
sed -i '/extern char   const octaspire_lightboard_animations/d'           $FILE
sed -i '/extern size_t const octaspire_lightboard_animations_len/d'       $FILE
sed -i '/extern char   const octaspire_lightboard_texture_entities/d'     $FILE
sed -i '/extern size_t const octaspire_lightboard_texture_entities_len/d' $FILE

cat >> $FILE << EnDoFmEsSaGe
//////////////////////////////////////////////////////////////////////////////////////////////////
// END OF          $INFILE
//////////////////////////////////////////////////////////////////////////////////////////////////



EnDoFmEsSaGe
}





concat_file_literally() {
INFILE=$1
cat >> $FILE << EnDoFmEsSaGe
//////////////////////////////////////////////////////////////////////////////////////////////////
// START OF        $INFILE
//////////////////////////////////////////////////////////////////////////////////////////////////
EnDoFmEsSaGe
cat $INFILE >> $FILE
cat >> $FILE << EnDoFmEsSaGe
//////////////////////////////////////////////////////////////////////////////////////////////////
// END OF          $INFILE
//////////////////////////////////////////////////////////////////////////////////////////////////



EnDoFmEsSaGe
}




cat >> $FILE << EnDoFmEsSaGe
#define OCTASPIRE_DERN_AMALGAMATED_IMPLEMENTATION
#define OCTASPIRE_EASING_AMALGAMATED_IMPLEMENTATION


EnDoFmEsSaGe




concat_file "../external/octaspire_dern/etc/octaspire_dern_amalgamated.c"
concat_file "../external/octaspire_easing/etc/octaspire_easing_amalgamated.c"
concat_file "../external/octaspire_sdl2_utils/include/octaspire/sdl2-utils/octaspire_sdl2_texture.h"
concat_file "../external/octaspire_sdl2_utils/include/octaspire/sdl2-utils/octaspire_sdl2_animation.h"
concat_file "../external/octaspire_lightboard_banner_color.h"
concat_file "../external/octaspire_lightboard_banner_white.h"

concat_config_file "../build/include/octaspire/lightboard/octaspire_lightboard_animations.c"
concat_config_file "../build/include/octaspire/lightboard/octaspire_lightboard_ini.c"
concat_config_file "../build/include/octaspire/lightboard/octaspire_lightboard_texture_entities.c"

concat_config_file "../build/include/octaspire/lightboard/octaspire_lightboard_config.h"

concat_file "../include/octaspire/lightboard/octaspire_lightboard_input.h"
concat_file "../include/octaspire/lightboard/octaspire_lightboard_state.h"
concat_file "../include/octaspire/lightboard/octaspire_lightboard_game.h"









cat >> $FILE << EnDoFmEsSaGe
#ifdef __cplusplus
extern "C" {
#endif

EnDoFmEsSaGe



# Write the bottom-part of the include guards
cat >> $FILE << EnDoFmEsSaGe
#ifdef __cplusplus
}
#endif

#endif

EnDoFmEsSaGe













# Write implementations



concat_file "../external/octaspire_sdl2_utils/src/octaspire_sdl2_texture.c"
concat_file "../external/octaspire_sdl2_utils/src/octaspire_sdl2_animation.c"

concat_file "../src/octaspire_lightboard_state.c"
concat_file "../src/octaspire_lightboard_game.c"
concat_lightboard_main_file "../src/octaspire_lightboard_main.c"


