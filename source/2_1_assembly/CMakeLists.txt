# Sources
set(2_1_SOURCES
    0_return.asm
    1_type_conversion.asm
    2_arithmetic.asm
    3_bitwise.asm
    4_memory.asm
    5_conditional.asm
    6_loop.asm
)

# Exercise
SET (2_1_EXERCISE_OBJECTS)
FOREACH(INPUT_FILE ${2_1_SOURCES})
    STRING(REGEX REPLACE ".asm\$" ".obj" OBJECT_FILE ${INPUT_FILE})
    nasm_assemble(
        "win32"
        "${CMAKE_CURRENT_BINARY_DIR}/${OBJECT_FILE}"
        "${CMAKE_CURRENT_SOURCE_DIR}/source/${INPUT_FILE}"
        INCLUDES
            "${CMAKE_CURRENT_SOURCE_DIR}/include/"
        FLAGS
            "-F" "cv8"
            "--prefix" "_"
    )
    SET(2_1_EXERCISE_OBJECTS ${2_1_EXERCISE_OBJECTS} "${CMAKE_CURRENT_BINARY_DIR}/${OBJECT_FILE}")
ENDFOREACH(INPUT_FILE)
add_library(2_1_exercise_lib STATIC ${2_1_EXERCISE_OBJECTS})
set_target_properties(2_1_exercise_lib PROPERTIES LINKER_LANGUAGE C)
add_gtest(2_1_assembly
    0_return_tests.cpp
    1_type_conversion_tests.cpp
    2_arithmetic_tests.cpp
    3_bitwise_tests.cpp
    4_memory_tests.cpp
    5_conditional_tests.cpp
    6_loop_tests.cpp
)
target_link_libraries(2_1_assembly 2_1_exercise_lib)

# Solution
SET (2_1_SOLUTION_OBJECTS)
FOREACH(INPUT_FILE ${2_1_SOURCES})
    STRING(REGEX REPLACE ".asm\$" ".obj" OBJECT_FILE ${INPUT_FILE})
    nasm_assemble(
        "win32"
        "${CMAKE_CURRENT_BINARY_DIR}/solution_${OBJECT_FILE}"
        "${CMAKE_CURRENT_SOURCE_DIR}/solution/${INPUT_FILE}"
        INCLUDES
            "${CMAKE_CURRENT_SOURCE_DIR}/include/"
        FLAGS
            "-F" "cv8"
            "--prefix" "_"          
    )
    SET(2_1_SOLUTION_OBJECTS ${2_1_SOLUTION_OBJECTS} "${CMAKE_CURRENT_BINARY_DIR}/solution_${OBJECT_FILE}")
ENDFOREACH(INPUT_FILE)

add_library(2_1_solution_lib STATIC ${2_1_SOLUTION_OBJECTS})
set_target_properties(2_1_solution_lib PROPERTIES LINKER_LANGUAGE C)
add_gtest(2_1_assembly_solution
    0_return_tests.cpp
    1_type_conversion_tests.cpp
    2_arithmetic_tests.cpp
    3_bitwise_tests.cpp
    4_memory_tests.cpp
    5_conditional_tests.cpp
    6_loop_tests.cpp
)
target_link_libraries(2_1_assembly_solution 2_1_solution_lib)
