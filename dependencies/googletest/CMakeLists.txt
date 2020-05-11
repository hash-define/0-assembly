# Provide a sane default that can be overriden
set(GOOGLETEST_OUTPUT_XML_DIR "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/gtest_output_xml" CACHE PATH "Path to gtest xml output directory" )

# Setup some paths
set(GOOGLETEST_VERSION "googletest-release-1.7.0")
set(GOOGLETEST_DIR "${CMAKE_CURRENT_SOURCE_DIR}/${GOOGLETEST_VERSION}")

# Add testing library
add_library(gtest STATIC ${GOOGLETEST_DIR}/src/gtest-all.cc)
target_include_directories(gtest PRIVATE ${GOOGLETEST_DIR})
target_include_directories(gtest PUBLIC ${GOOGLETEST_DIR}/include)

# Add executable helper
add_library(gtest_main STATIC ${GOOGLETEST_DIR}/src/gtest_main.cc)
target_link_libraries(gtest_main gtest)

set_target_properties(gtest gtest_main PROPERTIES FOLDER "external/googletest")

# GTest helper function
function(add_gtest TARGET_NAME) # ARGN: Source files
    # Define the binary
    add_executable(${TARGET_NAME} ${ARGN})

    # Link against required libraries
    target_link_libraries(${TARGET_NAME} gtest gtest_main)

    # Add to cmake testing
    add_test(
        NAME ${TARGET_NAME}
        COMMAND $<TARGET_FILE:${TARGET_NAME}> --gtest_shuffle --gtest_output=xml:${GOOGLETEST_OUTPUT_XML_DIR}/${TARGET_NAME}.xml
    )
endfunction()
 