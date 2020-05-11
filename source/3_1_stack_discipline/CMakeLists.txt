# Sources
set(3_1_SOURCES
    stack_discipline.asm
    arguments.asm
    simple_stack_frame.asm
)

# Exercise
SET (3_1_EXERCISE_OBJECTS)
FOREACH(INPUT_FILE ${3_1_SOURCES})
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
add_executable(3_1_stack_discipline ${3_1_EXERCISE_OBJECTS})
set_target_properties(3_1_stack_discipline PROPERTIES LINKER_LANGUAGE C)
set_target_properties(3_1_stack_discipline PROPERTIES LINK_FLAGS "/ENTRY:main /NODEFAULTLIB")
target_link_libraries(3_1_stack_discipline srelib)