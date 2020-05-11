#ifndef SRELIB_STRTOL_H
#define SRELIB_STRTOL_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

int32_t
SreLibStrtol
(
    const char *nptr,
    char **endptr,
    int32_t base
);

#ifdef __cplusplus
} // extern "C"
#endif

#endif // SRELIB_STRTOL_H
