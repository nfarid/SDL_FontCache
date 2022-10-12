
#Setup
cmake_minimum_required(VERSION 3.22.2)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE STRING "Create a compile_commands.json file")

project("SDL_FontCache"
    VERSION 0.10.0
    LANGUAGES C
)

include("cmake/util.cmake")

#This is for the cmake/FindLib.cmake files that is needed to find some libraries
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")


#Targets
add_subdirectory("src/")

#Examples
option(BUILD_EXAMPLE OFF)
if(BUILD_EXAMPLE)

    #Make sure that the everything are in predictable directories
    get_property(IS_MULTI_CONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
    if("${IS_MULTI_CONFIG}")
        foreach(CONFIG_TYPE IN ITEMS ${CMAKE_CONFIGURATION_TYPES})
            string(TOUPPER "${CONFIG_TYPE}" UPPERCASE_CONFIG_TYPE)
            set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${UPPERCASE_CONFIG_TYPE} "${CMAKE_BINARY_DIR}/Binary_${CONFIG_TYPE}")
            set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${UPPERCASE_CONFIG_TYPE} "${CMAKE_BINARY_DIR}/Library_${CONFIG_TYPE}")
            if(WIN32)
                set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${UPPERCASE_CONFIG_TYPE} "${CMAKE_BINARY_DIR}/Binary_${CONFIG_TYPE}")
            else()
                set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${UPPERCASE_CONFIG_TYPE} "${CMAKE_BINARY_DIR}/Library_${CONFIG_TYPE}")
            endif()
        endforeach()
    else()
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
        set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
        if(WIN32)
            set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
        else()
            set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
        endif()
    endif()

    #Symlink the asset directory
    symlink("${CMAKE_SOURCE_DIR}/data" "${CMAKE_BINARY_DIR}/data")

    add_subdirectory("examples/")
    #message(FATAL_ERROR "CMAKE_RUNTIME_OUTPUT_DIRECTORY: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")

endif()



