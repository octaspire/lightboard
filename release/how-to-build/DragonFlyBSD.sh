#!/usr/bin/env sh

YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NOCOLOR='\033[0m'

CC=gcc
COVERAGE=""

echoToDefs() { printf "$NOCOLOR\n" ; }

if [ "$#" -ge "1" ]; then CC=$1; fi
if [ "$2" = "--coverage" ]; then COVERAGE=$2; fi

printf "$YELLOW\n"
cat << EnDoFmEsSaGe
1. Building the game
   PLEASE NOTE: This game requires development version of 'SDL2' library
   (i.e. headers) to be installed on the system; otherwise compilation
   will fail. To install development version of library 'SDL2':

       - DragonFlyBSD: sudo pkg install sdl2
-------------------------------------------------------------------------------
EnDoFmEsSaGe
echoToDefs
read -r BUILDSTR <<EOF
$CC -O2 -std=c99 -Wall -Wextra -DOCTASPIRE_LIGHTBOARD_AMALGAMATED_IMPLEMENTATION \
    $COVERAGE                                                                    \
    octaspire-lightboard-amalgamated.c -o octaspire-lightboard                   \
    \`sdl2-config --cflags --libs\` -lm
EOF
echo $BUILDSTR
eval $BUILDSTR



printf "\nDone.\n$GREEN"
echo   "=================================================================="
echo   "Run the game like this:"
echo   "=================================================================="
printf "%b1)%b ./octaspire-lightboard\n" $YELLOW $GREEN
echo "=================================================================="
echoToDefs

