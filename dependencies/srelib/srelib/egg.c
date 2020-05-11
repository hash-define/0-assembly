#include <windows.h>
#include <srelib/egg.h>
#include <srelib/file.h>

#define BUFFER_SIZE 0x100
#define EGG         0xCAFEBABE
#define EGG_SIZE    4
#define XOR_VALUE   0x12

int32_t
SreLibPrepareEgg
(
    int32_t level,
    const char *filepath,
    uint8_t **buffer
)
{
    BOOL success = TRUE;
    int32_t shellcode_length = 0;
    int32_t slack = 0, offset = 0;
    DWORD egg = EGG;
    int32_t i;
    *buffer = NULL;
    
    // Allocate buffer
    // We use virtual alloc because we want to put shellcode in it
    if (success)
    {
        *buffer = VirtualAlloc(NULL,                        // lpAddress
                               BUFFER_SIZE,                 // dwSize
                               MEM_COMMIT | MEM_RESERVE,    // flAllocationType
                               PAGE_EXECUTE_READWRITE);     // flProtect
        success = *buffer != NULL;
    }

    // Read shellcode into buffer
    if (success)
    {
        shellcode_length = SreLibReadFile(filepath,     // filepath
                                          *buffer,      // buffer
                                          BUFFER_SIZE); // buffer_size
        success = shellcode_length > 0;
    }

    // Randomly relocate shellcode and place egg
    if (success && level > 0)
    {
        slack = BUFFER_SIZE - shellcode_length - EGG_SIZE;
        offset = (GetTickCount()>>4) % slack;

        // place shellcode 
        for (i = shellcode_length; i > 0; i--)
        {
            (*buffer)[offset+EGG_SIZE+i-1] = (*buffer)[i-1];
        }
        // place egg
        for (i = 0; i < sizeof(egg); i++)
        {
            (*buffer)[offset+i] = ((uint8_t *)&egg)[i];
        }

        // zero around for ease of reading
        for (i = 0; i < offset; i++)
        {
            (*buffer)[i] = 0xCC; 
        }
        for (i = 0; i < slack - offset; i++)
        {
            (*buffer)[offset+i+EGG_SIZE+shellcode_length] = 0xCC;
        }

    }

    // Obfuscate shellcode
    if (success && level > 1)
    {
        for (i = 0; i < shellcode_length; i++)
        {
            (*buffer)[offset+EGG_SIZE+i] ^= XOR_VALUE;
        }
    }

    // Free buffer on failure
    if (!success && NULL != buffer)
    {
        VirtualFree(buffer, 0, MEM_RELEASE);
    }
    
    // return
    return success ? BUFFER_SIZE : -1;

}

