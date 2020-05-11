# Sources
set(3_3_SOURCES
    local_buffer.asm
)

# Exercise
SET (3_1_EXERCISE_OBJECTS)
FOREACH(INPUT_FILE ${3_3_SOURCES})
    STRING(REGEX REPLACE ".asm\$" ".obj" OBJECT_FILE ${INPUT_FILE})
    nasm_assemble(
        "win32"
        "${CMAKE_CURRENT_BINARY_DIR}/${OBJECT_FILE}"
        "${CMAKE_CURRENT_SOURCE_DIR}/source/${INPUT_FILE}"
        FLAGS
            "-F" "cv8"
            "--prefix" "_"
    )
    SET(3_1_EXERCISE_OBJECTS ${3_1_EXERCISE_OBJECTS} "${CMAKE_CURRENT_BINARY_DIR}/${OBJECT_FILE}")
ENDFOREACH(INPUT_FILE)
add_executable(3_3_local_buffer ${3_1_EXERCISE_OBJECTS})
set_target_properties(3_3_local_buffer PROPERTIES LINKER_LANGUAGE C)
set_target_properties(3_3_local_buffer PROPERTIES LINK_FLAGS "/ENTRY:main /NODEFAULTLIB")
target_link_libraries(3_3_local_buffer srelib)

# Solution
SET (3_1_SOLUTION_OBJECTS)
FOREACH(INPUT_FILE ${3_3_SOURCES})
    STRING(REGEX REPLACE ".asm\$" ".obj" OBJECT_FILE ${INPUT_FILE})
    nasm_assemble(
        "win32"
        "${CMAKE_CURRENT_BINARY_DIR}/solution_${OBJECT_FILE}"
        "${CMAKE_CURRENT_SOURCE_DIR}/solution/${INPUT_FILE}"
        FLAGS
            "-F" "cv8"
            "--prefix" "_"
    )
    SET(3_1_SOLUTION_OBJECTS ${3_1_SOLUTION_OBJECTS} "${CMAKE_CURRENT_BINARY_DIR}/solution_${OBJECT_FILE}")
ENDFOREACH(INPUT_FILE)
add_executable(3_3_local_buffer_solution ${3_1_SOLUTION_OBJECTS})
set_target_properties(3_3_local_buffer_solution PROPERTIES LINKER_LANGUAGE C)
set_target_properties(3_3_local_buffer_solution PROPERTIES LINK_FLAGS "/ENTRY:main /NODEFAULTLIB")
target_link_libraries(3_3_local_buffer_solution srelib)