#include <windows.h>
#include <srelib/file.h>

int32_t
SreLibReadFile
(
    const char *filepath,
    uint8_t *buffer,
    uint32_t buffer_size
)
{
    HANDLE h;
    int64_t file_size = -1;
    BOOL success;
    DWORD dummy;
    
    if (NULL == filepath || NULL == buffer)
    {
        return -1;
    }

    // Open file
    h = CreateFileA(filepath,        // lpFileName
                    GENERIC_READ,    // dwDesiredAccess
                    0,               // dwShareMode
                    NULL,            // lpSecurityAttributes
                    OPEN_EXISTING,   // dwCreationDisposition
                    0,               // dwFlagsAndAttributes
                    NULL);           // hTemplateFile
    success = (INVALID_HANDLE_VALUE != h);

    // Read its length
    if (success)
    {
        success = GetFileSizeEx(h, (PLARGE_INTEGER)&file_size);
    }

    // Validate size
    if (success && file_size > buffer_size)
    {
        success = FALSE;
    }

    // Read file into buffer
    if (success)
    {
        success = ReadFile(h,                   // hFile
                           buffer,              // lpBuffer
                           (int32_t)file_size,  // nNumberOfBytesToRead
                           &dummy,              // lpNumberOfBytesRead
                           NULL);               // lpOverlapped
    }

    // close file
    if (INVALID_HANDLE_VALUE != h)
    {
        CloseHandle(h);
        h = INVALID_HANDLE_VALUE;
    }
    
    // return
    return success ? ((int32_t)file_size) : -1;

}

