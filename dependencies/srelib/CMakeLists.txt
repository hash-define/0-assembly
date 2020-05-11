set(SRELIB_SOURCES
    srelib/strtol.c     srelib/strtol.h
    srelib/printf.c     srelib/printf.h
    srelib/file.c       srelib/file.h
    srelib/egg.c        srelib/egg.h
    srelib/readint.c    srelib/readint.h
    srelib/char.c       srelib/char.h
)

add_library(srelib STATIC ${SRELIB_SOURCES})
target_include_directories(srelib PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}")

# generate test
add_gtest(srelib_tests
    strtol_tests.cpp
    printf_tests.cpp
    file_tests.cpp
    egg_tests.cpp
)
target_link_libraries(srelib_tests srelib shlwapi.lib)
