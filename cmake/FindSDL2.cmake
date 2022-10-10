
###############################################################################
#                                                                             #
#                                                                             #
# This module defines the library SDL2::core                                  #
# This module define the variable SDL2_FOUND                                  #
#                                                                             #
# Example:                                                                    #
#   find_package("SDL2" MODULE REQUIRED)                                      #
#   target_link_libraries("my_app" PRIVATE "SDL2::core")                      #
#                                                                             #
###############################################################################


include("SelectLibraryConfigurations")
include("FindPackageHandleStandardArgs")



if("${CMAKE_SYSTEM_NAME}" STREQUAL "Emscripten") #This works for some reason
    message(STATUS "Emscripten find")
    add_library("SDL2::core" IMPORTED INTERFACE)
    target_compile_options("SDL2::core" INTERFACE "-sUSE_SDL=2")
    target_link_options("SDL2::core" INTERFACE "-sUSE_SDL=2")
    return()
endif()




message(DEBUG "Looking for SDL's include directory")
find_path(SDL2_INCLUDE_DIRECTORY "SDL2/SDL.h"
    PATH_SUFFIXES "include"
)
message(VERBOSE "SDL2_INCLUDE_DIRECTORY: ${SDL2_INCLUDE_DIRECTORY}")



message(DEBUG "Looking for the SDL library")

message(DEBUG "Look for the release SDL library")
find_library(SDL2_LIBRARY_RELEASE
    NAMES "SDL2"
    PATH_SUFFIXES "lib"
)
message(VERBOSE "SDL2_LIBRARY_RELEASE: ${SDL2_LIBRARY_RELEASE}")

message(DEBUG "Look for the debug SDL library")
find_library(SDL2_LIBRARY_DEBUG
    NAMES "SDL2d" "SDL2"
    PATH_SUFFIXES "debug/lib" "lib"
)
message(VERBOSE "SDL2_LIBRARY_DEBUG: ${SDL2_LIBRARY_DEBUG}")

message(DEBUG "Set SDL2_LIBRARY to a suitable value using SelectLibraryConfigurations")
# https://cmake.org/cmake/help/latest/module/SelectLibraryConfigurations.html
select_library_configurations("SDL2")
message(DEBUG "SDL2_LIBRARY: ${SDL2_LIBRARY}")



message(DEBUG "Using FindPackageHandleStandardArgs to handle arguments of find_package")
# https://cmake.org/cmake/help/latest/module/FindPackageHandleStandardArgs.html
find_package_handle_standard_args("SDL2"
    REQUIRED_VARS SDL2_LIBRARY SDL2_INCLUDE_DIRECTORY #the header and library must be found
)
message(VERBOSE "SDL2_FOUND: ${SDL2_FOUND}")



message(DEBUG "Defining SDL2::core")
#IMPORTED because this is a pre-existing depedency
#UNKNOWN to prevent IMPORTED_IMPLIB errors (even though SDL will be dynamically linked)
message(TRACE "SDL2::core is a shared library")
add_library("SDL2::core" IMPORTED UNKNOWN)
set_target_properties("SDL2::core" PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${SDL2_INCLUDE_DIRECTORY}"
)

message(DEBUG "Add either the release or debug library to SDL2::core")
# https://cmake.org/cmake/help/latest/command/if.html#variable-expansion
if(SDL2_LIBRARY_RELEASE)
    set_target_properties("SDL2::core" PROPERTIES
        IMPORTED_LOCATION_RELEASE "${SDL2_LIBRARY_RELEASE}"
    )
    set_property(TARGET "SDL2::core" APPEND PROPERTY
        IMPORTED_CONFIGURATIONS "RELEASE"
    )
endif()
if(SDL2_LIBRARY_DEBUG)
    set_target_properties("SDL2::core" PROPERTIES
        IMPORTED_LOCATION_DEBUG "${SDL2_LIBRARY_DEBUG}"
    )
    set_property(TARGET "SDL2::core" APPEND PROPERTY
        IMPORTED_CONFIGURATIONS "DEBUG"
    )
endif()
if( (NOT SDL2_LIBRARY_RELEASE) AND (NOT SDL2_LIBRARY_DEBUG) )
    set_target_properties("SDL2::core" PROPERTIES
        IMPORTED_LOCATION "${SDL2_LIBRARY}"
    )
endif()


message(STATUS "Library SDL2::core can now be linked to.")
