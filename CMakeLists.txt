
#Setup
cmake_minimum_required(VERSION 3.22.2)
project("SDL_FontCache"
    VERSION 0.10.0
    LANGUAGES C
)

#Default output directories
if(NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/lib")
endif()

if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/lib")
endif()

#Targets
add_subdirectory("src/")



