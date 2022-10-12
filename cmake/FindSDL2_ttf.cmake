
###############################################################################
#                                                                             #
#                                                                             #
# This module defines the library SDL2::ttf                                   #
# This module define the variable SDL2_ttf_FOUND                              #
#                                                                             #
# Example:                                                                    #
#   find_package("SDL2_ttf" MODULE REQUIRED)                                  #
#   target_link_libraries("my_app" PRIVATE "SDL2::ttf")                       #
#                                                                             #
###############################################################################


include("FindPackageHandleStandardArgs")
include("SelectLibraryConfigurations")



if("${CMAKE_SYSTEM_NAME}" STREQUAL "Emscripten")
    message(TRACE "Special handling for emscripten's SDL2_ttf")
    add_library("SDL2::ttf" IMPORTED INTERFACE)
    target_compile_options("SDL2::ttf" INTERFACE "-sUSE_SDL_TTF=2")
    target_link_options("SDL2::ttf" INTERFACE "-sUSE_SDL_TTF=2")
    set(SDL2_ttf_FOUND ON)
    return()
endif()



message(DEBUG "Looking for SDL's include directory")
find_path(SDL2_ttf_INCLUDE_DIRECTORY "SDL2/SDL_ttf.h"
    PATH_SUFFIXES "include"
)
message(VERBOSE "SDL2_ttf_INCLUDE_DIRECTORY: ${SDL2_ttf_INCLUDE_DIRECTORY}")



message(DEBUG "Looking for the SDL_ttf library")

message(DEBUG "Look for the release SDL_ttf library")
#vcpkg's debug SDL2_ttf library is called SDL_ttf and not SDL2_ttfd
#This essentially means that this hackery is needed to make vcpkg find the release library
if(VCPKG_INSTALLED_DIR AND VCPKG_TARGET_TRIPLET)
    find_library(SDL2_ttf_LIBRARY_RELEASE
        NAMES "SDL2_ttf"
        HINTS "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib"
        NO_DEFAULT_PATH
    )
endif()
if(NOT SDL2_ttf_LIBRARY_RELEASE)
    find_library(SDL2_ttf_LIBRARY_RELEASE
        NAMES "SDL2_ttf"
        PATH_SUFFIXES "lib"
    )
endif()
message(VERBOSE "SDL2_ttf_LIBRARY_RELEASE: ${SDL2_ttf_LIBRARY_RELEASE}")

message(DEBUG "Look for the debug SDL_ttf library")
find_library(SDL2_ttf_LIBRARY_DEBUG
    NAMES "SDL2_ttfd" "SDL2_ttf"
    PATH_SUFFIXES "debug/lib" "lib"
)
message(VERBOSE "SDL2_ttf_LIBRARY_DEBUG: ${SDL2_ttf_LIBRARY_DEBUG}")

message(DEBUG "Set SDL2_ttf_LIBRARY to a suitable value using SelectLibraryConfigurations")
select_library_configurations("SDL2_ttf")
message(DEBUG "SDL2_ttf_LIBRARY: ${SDL2_ttf_LIBRARY}")



message(DEBUG "Using FindPackageHandleStandardArgs to handle arguments of find_package")
find_package_handle_standard_args("SDL2_ttf"
    REQUIRED_VARS SDL2_ttf_LIBRARY SDL2_ttf_INCLUDE_DIRECTORY
)
message(VERBOSE "SDL2_ttf_FOUND: ${SDL2_ttf_FOUND}")



message(DEBUG "Defining SDL2::ttf")
add_library("SDL2::ttf" IMPORTED UNKNOWN)
set_target_properties("SDL2::ttf" PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${SDL2_ttf_INCLUDE_DIRECTORY}"
)

message(DEBUG "Add either the release or debug library to SDL2::ttf")
if(SDL2_ttf_LIBRARY_RELEASE)
    set_target_properties("SDL2::ttf" PROPERTIES
        IMPORTED_LOCATION_RELEASE "${SDL2_ttf_LIBRARY_RELEASE}"
    )
    set_property(TARGET "SDL2::ttf" APPEND PROPERTY
        IMPORTED_CONFIGURATIONS "RELEASE"
    )
endif()
if(SDL2_ttf_LIBRARY_DEBUG)
    set_target_properties("SDL2::ttf" PROPERTIES
        IMPORTED_LOCATION_DEBUG "${SDL2_ttf_LIBRARY_DEBUG}"
    )
    set_property(TARGET "SDL2::ttf" APPEND PROPERTY
        IMPORTED_CONFIGURATIONS "DEBUG"
    )
endif()
if( (NOT SDL2_ttf_LIBRARY_RELEASE) AND (NOT SDL2_ttf_LIBRARY_DEBUG) )
    set_target_properties("SDL2::ttf" PROPERTIES
        IMPORTED_LOCATION "${SDL2_ttf}"
    )
endif()


message(NOTICE "Library SDL2::ttf can now be linked to.")
