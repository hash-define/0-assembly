#include <srelib/strtol.h>

int
SreLibIsUpper
(
    char c
)
{
    return (c >= 'A' && c <= 'Z');
}

int
SreLibIsAlpha
(
    char c
)
{
    return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z');
}

int
SreLibIsSpace
(
    char c
)
{
    return (c == ' ' || c == '\t' || c == '\n' || c == '\12');
}

int
SreLibIsDigit
(
    char c
)
{
    return (c >= '0' && c <= '9');
}

int
SreLibIsPrint
(
    char c
)
{
   return (c >= ' ' && c < 127); 
}

int
SreLibIsPunc
(
    char c
)
{
    return (c >= ' ' && c <= '/') || (c >= ':' && c <= '@') || (c >= '[' && c <= '`') || (c >= '{' && c <= '~'); 
}
