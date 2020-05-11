# Excercise
nasm_assemble(
    "win32"
    "${CMAKE_CURRENT_BINARY_DIR}/hello.obj"
    "${CMAKE_CURRENT_SOURCE_DIR}/source/hello.asm"
    FLAGS
    "-F" "cv8"
    "--prefix" "_"
)
add_executable(1_1_hello_world ${CMAKE_CURRENT_BINARY_DIR}/hello.obj ${CMAKE_CURRENT_SOURCE_DIR}/source/hello.asm)
set_target_properties(1_1_hello_world PROPERTIES LINKER_LANGUAGE C)
set_target_properties(1_1_hello_world PROPERTIES LINK_FLAGS "/ENTRY:main /NODEFAULTLIB")
target_link_libraries(1_1_hello_world srelib)

# Solution
nasm_assemble(
    "win32"
    "${CMAKE_CURRENT_BINARY_DIR}/hello_solution.obj"
    "${CMAKE_CURRENT_SOURCE_DIR}/solution/hello.asm"
    FLAGS
    "-F" "cv8"
    "--prefix" "_"
)
add_executable(1_1_hello_world_solution ${CMAKE_CURRENT_BINARY_DIR}/hello_solution.obj ${CMAKE_CURRENT_SOURCE_DIR}/solution/hello.asm)
set_target_properties(1_1_hello_world_solution PROPERTIES LINKER_LANGUAGE C)
set_target_properties(1_1_hello_world_solution PROPERTIES LINK_FLAGS "/ENTRY:main /NODEFAULTLIB")
target_link_libraries(1_1_hello_world_solution srelib)