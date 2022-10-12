
#Setup
cmake_minimum_required(VERSION 3.22.2)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE STRING "Create a compile_commands.json file")

project("SDL_FontCache"
    VERSION 0.10.0
    LANGUAGES C
)

#This is for the cmake/FindLib.cmake files that is needed to find some libraries
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")


#Targets
add_subdirectory("src/")

#Examples
option(BUILD_EXAMPLE OFF)
if(BUILD_EXAMPLE)
    add_subdirectory("examples/")
endif()



