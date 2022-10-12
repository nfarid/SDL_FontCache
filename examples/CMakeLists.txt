
include("CheckFunctionExists")

add_executable("SDL_FontCache_Example"
    "main.c"
)

target_link_libraries("SDL_FontCache_Example"
    PRIVATE "SDL2::ttf::cache"
)

#For some reason it won't build on GCC nor clang without without this
#This explicity links to the libm (maths library)
if("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU" OR "${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
    if(NOT SIN_FUNCTION_EXISTS AND NOT NEED_LINKING_AGAINST_LIBM)
      check_function_exists("sin" SIN_FUNCTION_EXISTS)
      if(NOT SIN_FUNCTION_EXISTS)
          unset(SIN_FUNCTION_EXISTS CACHE)
          list(APPEND CMAKE_REQUIRED_LIBRARIES "m")
          check_function_exists("sin" SIN_FUNCTION_EXISTS)
          if(SIN_FUNCTION_EXISTS)
              set(NEED_LINKING_AGAINST_LIBM ON CACHE BOOL "" FORCE)
          else()
              message(FATAL_ERROR "Failed making the sin() function available")
          endif()
      endif()
    endif()
    if (NEED_LINKING_AGAINST_LIBM)
         target_link_libraries("SDL_FontCache_Example"
             PRIVATE "m"
        )
    endif()
endif()
