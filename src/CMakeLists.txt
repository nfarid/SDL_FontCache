
#Building the library

add_library("SDL_FontCache"
    "SDL_FontCache.c"
    "${PROJECT_SOURCE_DIR}/include/SDL_FontCache/SDL_FontCache.h"
)

target_include_directories("SDL_FontCache"
    PUBLIC "${PROJECT_SOURCE_DIR}/include/"
)


#External dependencies
if("${CMAKE_SYSTEM_NAME}" STREQUAL "Emscripten")
    target_compile_options("SDL_FontCache"
        PUBLIC "-sUSE_SDL=2"
        PUBLIC "-sUSE_SDL_TTF=2"
    )
    target_link_options("SDL_FontCache"
        PUBLIC "-sUSE_SDL=2"
        PUBLIC "-sUSE_SDL_TTF=2"
    )
else()
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
endif()
