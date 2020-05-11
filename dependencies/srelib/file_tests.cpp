#include <gtest/gtest.h>
#include <srelib/srelib.h>
#include <windows.h>
#include <string.h>
#include <shlwapi.h>

TEST(Srelib, File)
{
    const char *path = "C:\\windows\\temp\\srelibtest.txt";
    const char *data = "Hello, World!";
    DWORD dummy;
    HANDLE h = CreateFileA(path, GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
    ASSERT_NE(h, INVALID_HANDLE_VALUE);
    ASSERT_EQ(TRUE, WriteFile(h, data, strlen(data), &dummy, NULL));
    CloseHandle(h);

    uint8_t *buffer = (uint8_t *)VirtualAlloc(NULL,                     // lpAddress
                                              strlen(data) + 1,         // dwSize
                                              MEM_COMMIT | MEM_RESERVE, // flAllocationType
                                              PAGE_EXECUTE_READWRITE);  // flProtect
    ASSERT_NE((void *)buffer, (void *)NULL);
    int32_t length = SreLibReadFile(path,               // path
                                    buffer,             // buffer
                                    strlen(data) + 1);  // buffer_size

    ASSERT_GT(length, 0);

    // Null terminate
    buffer[strlen(data)] = '\0';
    ASSERT_STREQ(data, (char *)buffer);
    
    VirtualFree(buffer, 0, MEM_RELEASE);
    buffer = NULL;

    DeleteFileA(path);
}
