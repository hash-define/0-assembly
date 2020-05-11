#include <windows.h>
#include <srelib/readint.h>
#include <srelib/strtol.h>

static
char
getchar
(
    void
)
{
    DWORD num;
    char c;
    HANDLE hStdout = GetStdHandle(STD_INPUT_HANDLE);
    (void)ReadConsole(hStdout,     // hConsoleOutput
                      &c,          // lpBuffer
                      1,           // nNumberOfCharsToRead
                      &num,        // lpNumberOfCharsRead
                      0);    // lpReserved
    return c;
}


#define BUF_LEN 32

int32_t
SreLibReadInt
(
    void
)
{
    char buf[BUF_LEN];
    char c;
    int i = 0;
    while('\n' != (c = getchar()))
    {
        if (i < sizeof(buf)-1)
        {
            buf[i++] = c;
            buf[i+1] = '\0';
        }
    }

    return SreLibStrtol(buf, NULL, 0);
}
