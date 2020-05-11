#include <gtest/gtest.h>
#include <windows.h>
#include <string.h>
#include <stdint.h>

extern "C" int __cdecl sign_extend(uint8_t x);
extern "C" int __cdecl zero_extend(uint8_t x);
extern "C" long long __cdecl doubleword_to_quadword(long x);

TEST(AssemblyTypeConversion, SignExtend)
{
    ASSERT_EQ(0, sign_extend(0));
    ASSERT_EQ(1, sign_extend(1));
    ASSERT_EQ(-1, sign_extend(-1));
}

TEST(AssemblyTypeConversion, ZeroExtend)
{
    ASSERT_EQ(0, zero_extend(0));
    ASSERT_EQ(1, zero_extend(1));
    ASSERT_EQ(0xFF, zero_extend(-1));
}

TEST(AssemblyTypeConversion, Double2Quad)
{
    ASSERT_EQ(0, doubleword_to_quadword(0));
    ASSERT_EQ(1, doubleword_to_quadword(1));
    ASSERT_EQ(-1, doubleword_to_quadword(-1));
}