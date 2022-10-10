
#Building the library

add_library("SDL_FontCache"
    "SDL_FontCache.c"
    "${PROJECT_SOURCE_DIR}/include/SDL_FontCache/SDL_FontCache.h"
)

add_library("SDL2::ttf::cache" ALIAS "SDL_FontCache")

target_include_directories("SDL_FontCache"
    PUBLIC "${PROJECT_SOURCE_DIR}/include/"
)

find_package("SDL2" REQUIRED)
find_package("SDL2_ttf" REQUIRED)
target_link_libraries("SDL_FontCache"
    PUBLIC "SDL2::core"
    PUBLIC "SDL2::ttf"
)
