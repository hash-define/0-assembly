#include <gtest/gtest.h>
#include <srelib/srelib.h>
#include <windows.h>
#include <string.h>
#include <shlwapi.h>

TEST(Srelib, Egg)
{
    const char *path = "C:\\windows\\temp\\srelibtest.txt";
    const char *data = "Hello, World!";
    DWORD dummy;
    HANDLE h = CreateFileA(path, GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
    ASSERT_NE(h, INVALID_HANDLE_VALUE);
    ASSERT_EQ(TRUE, WriteFile(h, data, strlen(data), &dummy, NULL));
    CloseHandle(h);

    // Prepare egg
    uint8_t *buffer = NULL;
    int32_t length = SreLibPrepareEgg(2,        // level
                                      path,     // path
                                      &buffer); // buffer
    ASSERT_EQ(length, 0x100);
    ASSERT_NE((void *)buffer, (void *)NULL);

    int i;
    for (i = 0; i < length - 4; i++)
    {
        if (*((DWORD *)(buffer + i)) == 0xCAFEBABE)
        {
            break;
        }
    }
    ASSERT_EQ(0xCAFEBABE, *((DWORD *)(buffer + i)));

    // De-obfuscate
    for (uint32_t j = 0; j < strlen(data); j++)
    {
        buffer[i+4+j] ^= 0x12;
    }
    ASSERT_STREQ((char *)(buffer + i + 4), data);

    DeleteFileA(path);
}
