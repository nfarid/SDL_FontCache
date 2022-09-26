
add_executable("SDL_FontCache_example"
    "main.c"
)

target_link_libraries("SDL_FontCache_example"
    PRIVATE "SDL_FontCache"
)


#For some reason it won't build on GCC nor clang without without this
#This explicity links to the libm (maths library)
if("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU" OR "${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
    include("CheckFunctionExists")
    if(NOT SIN_FUNCTION_EXISTS AND NOT NEED_LINKING_AGAINST_LIBM)
      CHECK_FUNCTION_EXISTS("sin" SIN_FUNCTION_EXISTS)
      if(NOT SIN_FUNCTION_EXISTS)
          unset(SIN_FUNCTION_EXISTS CACHE)
          list(APPEND CMAKE_REQUIRED_LIBRARIES "m")
          CHECK_FUNCTION_EXISTS("sin" SIN_FUNCTION_EXISTS)
          if(SIN_FUNCTION_EXISTS)
              set(NEED_LINKING_AGAINST_LIBM True CACHE BOOL "" FORCE)
          else()
              message(FATAL_ERROR "Failed making the sin() function available")
          endif()
      endif()
    endif()
    if (NEED_LINKING_AGAINST_LIBM)
         target_link_libraries("SDL_FontCache_example"
             PRIVATE "m"
        )
    endif()
endif()
