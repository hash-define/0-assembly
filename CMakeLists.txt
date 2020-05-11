cmake_minimum_required(VERSION 3.5)
project(ASSEMBLY)
enable_language(C CXX)
enable_testing()

function(replace_flag VAR_NAME RE_EXPR FLAG)
    string(REGEX REPLACE ${RE_EXPR} "" ${VAR_NAME} "${${VAR_NAME}}")
    set(${VAR_NAME} "${${VAR_NAME}} ${FLAG}" PARENT_SCOPE)
endfunction()

foreach(LANG C CXX)
    replace_flag(CMAKE_${LANG}_FLAGS "/GS(|-)" "/GS-")            # disable security checks
    replace_flag(CMAKE_${LANG}_FLAGS "/RTC[1su]+" "")             # disable runtime checks
    replace_flag(CMAKE_${LANG}_FLAGS_DEBUG "/GS(|-)" "/GS-")            # disable security checks
    replace_flag(CMAKE_${LANG}_FLAGS_DEBUG "/RTC[1su]+" "")             # disable runtime checks
    replace_flag(CMAKE_${LANG}_FLAGS_RELEASE "/M[TD]" "/MT")
endforeach()

foreach(OUTPUT EXE MODULE SHARED)
    replace_flag(CMAKE_${OUTPUT}_LINKER_FLAGS "/MANIFEST(|:NO)" "/MANIFEST:NO")     # Disable Manifest Generation
endforeach()

# Set outputs under ./out
set(BASE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/../out")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${BASE_OUTPUT_DIRECTORY}/bin/${CMAKE_SYSTEM_PROCESSOR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${BASE_OUTPUT_DIRECTORY}/bin/${CMAKE_SYSTEM_PROCESSOR}")
set(GOOGLETEST_OUTPUT_XML_DIR "${BASE_OUTPUT_DIRECTORY}/gtest_output_xml/${CMAKE_SYSTEM_PROCESSOR}/$<CONFIG>/" CACHE OVERRIDE PATH "Path to gtest xml output directory" )

add_subdirectory(dependencies)
add_subdirectory(source)
