
#Building the library
set(SDL_FontCache_IncludeDir "${PROJECT_SOURCE_DIR}/include/SDL_FontCache")

add_library("SDL_FontCache"
    "SDL_FontCache.c"
    "${SDL_FontCache_IncludeDir}/SDL_FontCache.h"
)

target_include_directories("SDL_FontCache"
    PUBLIC "${SDL_FontCache_IncludeDir}"
)


#External dependencies
find_library("SDL2_LIBRARIES"
    NAME "SDL2"
    REQUIRED
)
find_library("SDL2_TTF_LIBRARY"
    NAME "SDL2_ttf"
    REQUIRED
)
target_link_libraries("SDL_FontCache"
    PUBLIC "${SDL2_LIBRARIES}"
    PUBLIC "${SDL2_TTF_LIBRARY}"
)
