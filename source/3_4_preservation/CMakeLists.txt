# Exercise
nasm_assemble(
    "win32"
    "${CMAKE_CURRENT_BINARY_DIR}/preservation.obj"
    "${CMAKE_CURRENT_SOURCE_DIR}/source/preservation.asm"
    FLAGS
        "-F" "cv8"
        "--prefix" "_"
)

add_executable(3_4_preservation ${CMAKE_CURRENT_BINARY_DIR}/preservation.obj ${CMAKE_CURRENT_SOURCE_DIR}/source/preservation.asm)
set_target_properties(3_4_preservation PROPERTIES LINKER_LANGUAGE C)
set_target_properties(3_4_preservation PROPERTIES LINK_FLAGS "/ENTRY:main /NODEFAULTLIB")
target_link_libraries(3_4_preservation srelib)

# Solution
nasm_assemble(
    "win32"
    "${CMAKE_CURRENT_BINARY_DIR}/preservation_solution.obj"
    "${CMAKE_CURRENT_SOURCE_DIR}/solution/preservation.asm"
    FLAGS
        "-F" "cv8"
        "--prefix" "_"
)

add_executable(3_4_preservation_solution ${CMAKE_CURRENT_BINARY_DIR}/preservation_solution.obj ${CMAKE_CURRENT_SOURCE_DIR}/solution/preservation.asm)
set_target_properties(3_4_preservation_solution PROPERTIES LINKER_LANGUAGE C)
set_target_properties(3_4_preservation_solution PROPERTIES LINK_FLAGS "/ENTRY:main /NODEFAULTLIB")
target_link_libraries(3_4_preservation_solution srelib)