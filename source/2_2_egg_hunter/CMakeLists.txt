# Shellcode blob
nasm_assemble(
    "bin"
    "${CMAKE_CURRENT_BINARY_DIR}/shellcode.bin"
    "${CMAKE_CURRENT_SOURCE_DIR}/source/shellcode.asm"
)
add_custom_target(2_2_egg_hunter_shellcode DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/shellcode.bin)
add_custom_command(TARGET 2_2_egg_hunter_shellcode POST_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/shellcode.bin" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$<CONFIG>/shellcode.bin")

# Exercise
nasm_assemble(
    "win32"
    "${CMAKE_CURRENT_BINARY_DIR}/egg.obj"
    "${CMAKE_CURRENT_SOURCE_DIR}/source/egg.asm"
    FLAGS
        "-F" "cv8"
        "--prefix" "_"
)

add_executable(2_2_egg_hunter ${CMAKE_CURRENT_BINARY_DIR}/egg.obj ${CMAKE_CURRENT_SOURCE_DIR}/source/egg.asm)
add_dependencies(2_2_egg_hunter 2_2_egg_hunter_shellcode)
set_target_properties(2_2_egg_hunter PROPERTIES LINKER_LANGUAGE C)
set_target_properties(2_2_egg_hunter PROPERTIES LINK_FLAGS "/ENTRY:main /NODEFAULTLIB")
target_link_libraries(2_2_egg_hunter srelib)

# Solution
nasm_assemble(
    "win32"
    "${CMAKE_CURRENT_BINARY_DIR}/egg_solution.obj"
    "${CMAKE_CURRENT_SOURCE_DIR}/solution/egg.asm"
    FLAGS
        "-F" "cv8"
        "--prefix" "_"
)

add_executable(2_2_egg_hunter_solution ${CMAKE_CURRENT_BINARY_DIR}/egg_solution.obj ${CMAKE_CURRENT_SOURCE_DIR}/solution/egg.asm)
add_dependencies(2_2_egg_hunter_solution 2_2_egg_hunter_shellcode)
set_target_properties(2_2_egg_hunter_solution PROPERTIES LINKER_LANGUAGE C)
set_target_properties(2_2_egg_hunter_solution PROPERTIES LINK_FLAGS "/ENTRY:main /NODEFAULTLIB")
target_link_libraries(2_2_egg_hunter_solution srelib)