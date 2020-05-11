#ifndef SRELIB_PRINTF_H
#define SRELIB_PRINTF_H

#include <stdint.h>
#include <stdarg.h>

#ifdef __cplusplus
extern "C" {
#endif

int
SreLibPrintf
(
    const char *format,
    ...
);

int
SreLibSprintf
(
    char *out,
    const char *format,
    ...
);

#ifdef __cplusplus
} // extern "C"
#endif

#endif // SRELIB_PRINTF_H
