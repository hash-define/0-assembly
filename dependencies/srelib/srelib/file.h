#ifndef SRELIB_FILE_H
#define SRELIB_FILE_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

int32_t
SreLibReadFile
(
    const char *filepath,
    uint8_t *buffer,
    uint32_t buffer_size
);

#ifdef __cplusplus
} // extern "C"
#endif

#endif // SRELIB_FILE_H
