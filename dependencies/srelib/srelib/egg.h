#ifndef SRELIB_EGG_H
#define SRELIB_EGG_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

int32_t
SreLibPrepareEgg
(
    int32_t level,
    const char *filepath,
    uint8_t **buffer
);

#ifdef __cplusplus
} // extern "C"
#endif

#endif // SRELIB_EGG_H
