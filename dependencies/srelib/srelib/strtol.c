#include <srelib/strtol.h>
#include <srelib/char.h>

int32_t
SreLibStrtol
(
    const char *nptr,
    char **endptr,
    int32_t base
)
{
    const char *s = nptr;
    int32_t acc;
    char c;
    int32_t neg = 0;

    // Skip whitespace
    // Pick up leading +/-
    // If base 0, allow for binary, octal or hex prefixes
    do
    {
        c = *s++;
    } while (SreLibIsSpace(c));
    if (c == '-')
    {
        neg = 1;
        c = *s++;
    }
    else if (c == '+')
    {
        c = *s++;
    }
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    {
        c = s[1];
        s += 2;
        base = 16;
    }
    else if ((base == 0 || base == 2) && c == '0' && (*s == 'b' || *s == 'B'))
    {
        c = s[1];
        s += 2;
        base = 2;
    }
    if (base == 0)
    {
        base = c == '0' ? 8 : 10;
    }

    // No overflow detection...
    for (acc = 0;; c = *s++)
    {
        if (SreLibIsDigit(c))
        {
            c -= '0';
        }
        else if (SreLibIsAlpha(c))
        {
            c -= SreLibIsUpper(c) ? 'A' - 10 : 'a' - 10;
        }
        else
        {
            break;
        }

        if (c >= base)
        {
            break;
        }

        acc *= base;
        acc += c;
    }

    if (neg)
    {
        acc = -acc;
    }

    if (0 != endptr)
    {
        *endptr = (char *)(s - 1);
    }

    return acc;
}
