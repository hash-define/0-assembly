#include <gtest/gtest.h>
#include <srelib/srelib.h>

TEST(Srelib, Strtol)
{
    char *endptr = nullptr;
    uint32_t base = 0;
    
    // decimal
    const char *decimal = "123";
    ASSERT_EQ(123, SreLibStrtol(decimal, &endptr, base));
    ASSERT_EQ('\0', *endptr);

    // binary
    const char *binary = "0b111";
    ASSERT_EQ(7, SreLibStrtol(binary, &endptr, base));
    ASSERT_EQ('\0', *endptr);

    // octal
    const char *octal = "0777";
    ASSERT_EQ(0777, SreLibStrtol(octal, &endptr, base));
    ASSERT_EQ('\0', *endptr);

    // hex
    const char *hex = "0xCAFEBABE";
    ASSERT_EQ(0xCAFEBABE, SreLibStrtol(hex, &endptr, base));
    ASSERT_EQ('\0', *endptr);
    
    // negative
    const char *negative = "-123";
    ASSERT_EQ(-123, SreLibStrtol(negative, &endptr, base));
    ASSERT_EQ('\0', *endptr);

    // whitespace
    const char *whitespace = "\t -123";
    ASSERT_EQ(-123, SreLibStrtol(whitespace, &endptr, base));
    ASSERT_EQ('\0', *endptr);

    // suffix
    const char *suffix = "1blah";
    ASSERT_EQ(1, SreLibStrtol(suffix, &endptr, base));
    ASSERT_EQ('b', *endptr);

}
