#ifndef SRELIB_CHAR_H
#define SRELIB_CHAR_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

int
SreLibIsUpper
(
    char c
);

int
SreLibIsAlpha
(
    char c
);

int
SreLibIsSpace
(
    char c
);

int
SreLibIsDigit
(
    char c
);

int
SreLibIsPrint
(
    char c
);

int
SreLibIsPunc
(
    char c
);

#ifdef __cplusplus
} // extern "C"
#endif

#endif // SRELIB_CHAR_H
