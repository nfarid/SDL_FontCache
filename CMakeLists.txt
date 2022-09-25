
#Setup
cmake_minimum_required(VERSION 3.22.2)
project("SDL_FontCache"
    VERSION 0.10.0
    LANGUAGES C
)


#Library source files
add_library("SDL_FontCache"
    "SDL_FontCache.h"
    "SDL_FontCache.c"
)


#Dependencies
find_library("SDL2_LIBRARIES"
    NAME "SDL2"
    REQUIRED
)
find_library("SDL2_TTF_LIBRARY"
    NAME "SDL2_ttf"
    REQUIRED
)
find_library("SDL2_IMAGE_LIBRARY"
    NAME "SDL2_image"
    REQUIRED
)
find_library("SDL2_MIXER_LIBRARY"
    NAME "SDL2_mixer"
    REQUIRED
)
target_link_libraries("SDL_FontCache"
    PUBLIC "${SDL2_LIBRARIES}"
    PUBLIC "${SDL2_TTF_LIBRARY}"
    PUBLIC "${SDL2_IMAGE_LIBRARY}"
    PUBLIC "${SDL2_MIXER_LIBRARY}"
    PUBLIC "FontCache"
)



