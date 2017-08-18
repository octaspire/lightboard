#!/usr/bin/env sh

YELLOW="$(tput setaf 3 ; tput bold)"
GREEN="$(tput setaf 2 ; tput bold)"
NOCOLOR="$(tput setaf 9 ; tput sgr0)"

echoToDefs() { printf "$NOCOLOR\n" ; }

printf "$YELLOW\n"
cat << EnDoFmEsSaGe
1. Building the game
   PLEASE NOTE: This game requires development version of 'SDL2' library
   (i.e. headers) to be installed on the system; otherwise compilation
   will fail. Compilation uses also 'pkgconf'. To install development
   version of library 'SDL2' and 'devel/pkgconf':

       - FreeBSD: sudo pkg install devel/sdl20 devel/pkgconf
-------------------------------------------------------------------------------
EnDoFmEsSaGe
echoToDefs
read -r BUILDSTR <<'EOF'
clang -O2 -std=c99 -Wall -Wextra -DOCTASPIRE_LIGHTBOARD_AMALGAMATED_IMPLEMENTATION octaspire-lightboard-amalgamated.c -o octaspire-lightboard `pkgconf --cflags --libs sdl2` -lm
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
