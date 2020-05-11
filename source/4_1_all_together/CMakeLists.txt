# Sources
set(4_1_SOURCES
    0_count_chars.asm
    1_count_lines.asm
    2_longest_line.asm
    3_count_words.asm
)

# Exercise
SET (4_1_EXERCISE_OBJECTS)
FOREACH(INPUT_FILE ${4_1_SOURCES})
    STRING(REGEX REPLACE ".asm\$" ".obj" OBJECT_FILE ${INPUT_FILE})
    nasm_assemble(
        "win32"
        "${CMAKE_CURRENT_BINARY_DIR}/${OBJECT_FILE}"
        "${CMAKE_CURRENT_SOURCE_DIR}/source/${INPUT_FILE}"
        FLAGS
            "-F" "cv8"
            "--prefix" "_"
    )
    SET(4_1_EXERCISE_OBJECTS ${4_1_EXERCISE_OBJECTS} "${CMAKE_CURRENT_BINARY_DIR}/${OBJECT_FILE}")
ENDFOREACH(INPUT_FILE)
add_library(4_1_exercise_lib STATIC ${4_1_EXERCISE_OBJECTS})
set_target_properties(4_1_exercise_lib PROPERTIES LINKER_LANGUAGE C)
add_gtest(4_1_all_together
    tests.cpp
)
target_link_libraries(4_1_all_together 4_1_exercise_lib srelib)

# Solution
SET (4_1_SOLUTION_OBJECTS)
FOREACH(INPUT_FILE ${4_1_SOURCES})
    STRING(REGEX REPLACE ".asm\$" ".obj" OBJECT_FILE ${INPUT_FILE})
    nasm_assemble(
        "win32"
        "${CMAKE_CURRENT_BINARY_DIR}/solution_${OBJECT_FILE}"
        "${CMAKE_CURRENT_SOURCE_DIR}/solution/${INPUT_FILE}"
        FLAGS
            "-F" "cv8"
            "--prefix" "_"          
    )
    SET(4_1_SOLUTION_OBJECTS ${4_1_SOLUTION_OBJECTS} "${CMAKE_CURRENT_BINARY_DIR}/solution_${OBJECT_FILE}")
ENDFOREACH(INPUT_FILE)

add_library(4_1_solution_lib STATIC ${4_1_SOLUTION_OBJECTS})
set_target_properties(4_1_solution_lib PROPERTIES LINKER_LANGUAGE C)
add_gtest(4_1_all_together_solution
    tests.cpp
)
target_link_libraries(4_1_all_together_solution 4_1_solution_lib srelib)
