#include <gtest/gtest.h>
#include <windows.h>
#include <string.h>
#include <stdint.h>

extern "C" int __cdecl return_zero(void);
extern "C" int __cdecl return_neg_one(void);
extern "C" int __cdecl return_cafebabe(void);

TEST(AssemblyReturn, ReturnZero)
{
    ASSERT_EQ(0, return_zero());
}

TEST(AssemblyReturn, ReturnNegOne)
{
    ASSERT_EQ(-1, return_neg_one());
}

TEST(AssemblyReturn, ReturnCAFEBABE)
{
    ASSERT_EQ(0xCAFEBABE, return_cafebabe());
}


