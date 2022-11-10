
include("CheckLibraryExists")

add_executable("SDL_FontCache_Example"
    "main.c"
)

target_link_libraries("SDL_FontCache_Example"
    PRIVATE "SDL2::ttf::cache"
)

#For some reason it won't build on GCC nor clang without without this
#This explicity links to the libm (maths library)
check_library_exists("m" "sin" "" LIBM)
if(LIBM)
    target_link_libraries("SDL_FontCache_Example" PRIVATE "m")
endif()
