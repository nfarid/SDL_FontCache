
#Make sure that the directory doesn't end with slash
function(symlink SRC_DIR DEST_DIR)
    message(STATUS "symlinking from ${SRC_DIR} to ${DEST_DIR}")
	#Only symlink if src_dir exists and dest_dir doesn't
    if(NOT EXISTS "${SRC_DIR}")
        message(WARNING "${SRC_DIR} does not exists")
        return()
    endif()
    if(EXISTS "${DEST_DIR}")
        message(VERBOSE "${DEST_DIR} already exists")
		return()
    endif()
	
	#Despite the fact the cmake_path was introduced in 3.20 (and hence modern)
	#The second argument takes the variable name and NOT the variable itself
	#Which is inconsistent with most cmake functions
	#WHY??????
	cmake_path(GET DEST_DIR PARENT_PATH PARENT_DEST_DIR)
	#Make sure that the parent directory of dest_dir exists, so the symlink works
	if(NOT EXISTS "${PARENT_DEST_DIR}")
		message(STATUS "CREATING PARENT_DEST_DIR")
		file(MAKE_DIRECTORY "${PARENT_DEST_DIR}")
	endif()
	
	#Now do the actual symlink
    if(WIN32) #Use a junction link instead on windows
        string(REPLACE "/" "\\" SRC_DIR "${SRC_DIR}")
        string(REPLACE "/" "\\" DEST_DIR "${DEST_DIR}")
        execute_process(COMMAND "cmd" "/C" "mklink" "/J" "${DEST_DIR}" "${SRC_DIR}")
    else()
		execute_process(COMMAND "${CMAKE_COMMAND}" "-E" "create_symlink" "${SRC_DIR}" "${DEST_DIR}")
	endif()
endfunction()

