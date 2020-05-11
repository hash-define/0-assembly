# If NASM has not been defined, point to this instance
if("${NASM_EXE_PATH}" STREQUAL "")
    # Version to select
    set(NASM_VERSION "2.13.01")

    # Export path to binary
    set(NASM_EXE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/nasm-${NASM_VERSION}/nasm.exe" CACHE INTERNAL "Path to nasm executable")
endif("${NASM_EXE_PATH}" STREQUAL "")

# Example usage:
#
# nasm_assemble(
#     "win32"
#     "${CMAKE_CURRENT_BINARY_DIR/myfile.obj"
#     "${CMAKE_CURRENT_SOURCE_DIR/myfile.asm"
#     INCLUDES "${CMAKE_CURRENT_SOURCE_DIR}/" "${OTHER_ASM_LIBRARY}/"
#     DEFINES "ENABLE_FEATURE_XXX"
# )
function(nasm_assemble FORMAT OUTPUT_OBJ INPUT_FILE) # ${ARGN}: INCLUDES/DEFINES/FLAGS
    set(INCLUDES "")
    set(DEFINES "")
    set(FLAGS "")
    set(VAR_NAME "INCLUDES")

    foreach(ARG ${ARGN})
        if(("${ARG}" STREQUAL "INCLUDES") OR ("${ARG}" STREQUAL "DEFINES") OR ("${ARG}" STREQUAL "FLAGS"))
            set(VAR_NAME ${ARG})
        else()
            list(APPEND ${VAR_NAME} ${ARG})
        endif()
    endforeach()

    # Build flags
    set(NASM_FLAGS "")
    
    # Select assembler output
    set(NASM_FLAGS ${NASM_FLAGS} -f ${FORMAT})

    # Includes
    foreach(INCLUDE_DIR ${INCLUDES})
        set(NASM_FLAGS ${NASM_FLAGS} -I ${INCLUDE_DIR})
    endforeach()
    
    # Defines
    foreach(DEFINE ${DEFINES})
        set(NASM_FLAGS ${NASM_FLAGS} -D ${DEFINE})
    endforeach()
    
    # Flags
    foreach(FLAG ${FLAGS})
        set(NASM_FLAGS ${NASM_FLAGS} ${FLAG})
    endforeach()

    ADD_CUSTOM_COMMAND(
        OUTPUT ${OUTPUT_OBJ}
        COMMAND ${NASM_EXE_PATH} ${NASM_FLAGS} -o ${OUTPUT_OBJ} ${INPUT_FILE}
        DEPENDS ${INPUT_FILE}
        COMMENT "${NASM_EXE_PATH} ${NASM_FLAGS} -o ${OUTPUT_OBJ} ${INPUT_FILE}"
    )
endfunction()

