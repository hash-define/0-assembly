Common CMake files for using nasm.exe

Example usage:
```
nasm_assemble(
    "win32"
    "${CMAKE_CURRENT_BINARY_DIR/myfile.obj"
    "${CMAKE_CURRENT_SOURCE_DIR/myfile.asm"
    INCLUDES "${CMAKE_CURRENT_SOURCE_DIR}/" "${OTHER_ASM_LIBRARY}/"
    DEFINES "ENABLE_FEATURE_XXX"
)
```