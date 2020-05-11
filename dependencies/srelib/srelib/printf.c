#include <windows.h>
#include <srelib/printf.h>

static
void
putchar
(
    char c
)
{
    DWORD num;
    HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE);
    (void)WriteConsole(hStdout,     // hConsoleOutput
                       &c,          // lpBuffer
                       1,           // nNumberOfCharsToWrite
                       &num,        // lpNumberOfCharsWritten
                       0);    // lpReserved
}

static
void
printchar
(
    char **str,
    char c
)
{
    if (0 != str)
    {
        **str = c;
        ++(*str);
    }
    else
    {
        (void)putchar(c);
    }
}

#define PAD_RIGHT   (1<<0)
#define PAD_ZERO    (1<<1)

static
int
prints
(
    char **out,
    const char *string,
    int width,
    int pad
)
{
    int pc = 0;
    char padchar = ' ';

    if (width > 0)
    {
        int len = 0;
        const char *ptr;
        for (ptr = string; *ptr; ++ptr)
        {
            ++len;
        }
        if (len >= width)
        {
            width = 0;
        }
        else
        {
            width -= len;
        }
        if (pad & PAD_ZERO)
        {
            padchar = '0';
        }
    }

    if (!(pad & PAD_RIGHT))
    {
        for( ; width > 0; --width)
        {
            printchar(out, padchar);
            ++pc;
        }
    }
    for ( ; *string; ++string)
    {
        printchar(out, *string);
        ++pc;
    }
    for ( ; width > 0; --width)
    {
        printchar(out, padchar);
        ++pc;
    }

    return pc;
}

#define BUF_LEN 12

static
int
printi
(
    char **out,
    int i,
    int b,
    int sg,
    int width,
    int pad,
    int letbase
)
{
    char buf[BUF_LEN];
    char *s;
    int t, neg = 0, pc = 0;
    unsigned int u = i;

    if (i == 0)
    {
        buf[0] = '0';
        buf[1] = '\0';
        return prints(out, buf, width, pad);
    }

    if (sg && b == 10 && i < 0)
    {
        neg = 1;
        u = -i;
    }

    s = buf + BUF_LEN - 1;
    *s = '\0';

    while (u)
    {
        t = u % b;
        if (t >= 10)
        {
            t += letbase - '0' - 10;
        }
        *--s = (char)(t + '0');
        u /= b;
    }

    if (neg)
    {
        if (width && (pad & PAD_ZERO))
        {
            printchar(out, '-');
            ++pc;
            --width;
        }
        else
        {
            *--s = '-';
        }
    }
    
    return pc + prints(out, s, width, pad);
}

static
int
print
(
    char **out,
    const char *format,
    va_list args
)
{
    int width, pad;
    int pc = 0;
    char scr[2];

    for( ; *format != 0; ++format)
    {
        if (*format == '%')
        {
            ++format;
            width = pad = 0;
            if (*format =='\0') break;
            if (*format == '%') goto out;
            if (*format == '-')
            {
                ++format;
                pad = PAD_RIGHT;
            }
            while (*format == '0')
            {
                ++format;
                pad |= PAD_ZERO;
            }
            for ( ; *format >= '0' && *format <= '9'; ++format)
            {
                width *= 10;
                width += *format - '0';
            }
            if (*format == 's')
            {
                char *s = (char *)va_arg(args, int);
                pc += prints(out, s ? s : "(null)", width, pad);
                continue;
            }
            if (*format == 'd')
            {
                pc += printi(out, va_arg(args, int), 10, 1, width, pad, 'a');
                continue;
            }
            if (*format == 'x')
            {
                pc += printi(out, va_arg(args, int), 16, 0, width, pad, 'a');
                continue;
            }
            if (*format == 'X')
            {
                pc += printi(out, va_arg(args, int), 16, 0, width, pad, 'A');
                continue;
            }
            if (*format == 'u')
            {
                pc += printi(out, va_arg(args, int), 10, 0, width, pad, 'a');
                continue;
            }
            if (*format == 'c')
            {
                scr[0] = (char)va_arg(args, int);
                scr[1] = '\0';
                pc += prints(out, scr, width, pad);
                continue;
            }
        }
        else
        {
        out:
            printchar(out, *format);
            ++pc;
        }
    }

    if (out) **out = '\0';
    va_end(args);
    return pc;
}

int
SreLibPrintf
(
    const char *format,
    ...
)
{
    va_list args;
    va_start(args, format);
    return print(0, format, args);
}

int
SreLibSprintf
(
    char *out,
    const char *format,
    ...
)
{
    va_list args;
    va_start(args, format);
    return print(&out, format, args);
}
