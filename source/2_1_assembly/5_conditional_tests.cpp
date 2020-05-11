#include <gtest/gtest.h>
#include <windows.h>
#include <string.h>
#include <stdint.h>

extern "C" bool __cdecl is_equal(int a, int b);
extern "C" bool __cdecl is_greater_than(int a, int b);
extern "C" bool __cdecl is_less_than(int a, int b);
extern "C" bool __cdecl is_bit_set(int x, int mask);

TEST(AssemblyConditional, IsEqual)
{
    ASSERT_EQ(true, is_equal(0,0));
    ASSERT_EQ(false, is_equal(0,1));
}

TEST(AssemblyConditional, IsGreaterThan)
{
    ASSERT_EQ(false, is_greater_than(0,0));
    ASSERT_EQ(false, is_greater_than(0,1));
    ASSERT_EQ(true, is_greater_than(1,0));
    ASSERT_EQ(false, is_greater_than(1,1));
}

TEST(AssemblyConditional, IsLessThan)
{
    ASSERT_EQ(false, is_less_than(0,0));
    ASSERT_EQ(true, is_less_than(0,1));
    ASSERT_EQ(false, is_less_than(1,0));
    ASSERT_EQ(false, is_less_than(1,1));
}

TEST(AssemblyConditional, IsBitSet)
{
    ASSERT_EQ(false, is_bit_set(0,0));
    ASSERT_EQ(false, is_bit_set(0,1));
    ASSERT_EQ(false, is_bit_set(1,0));
    ASSERT_EQ(true, is_bit_set(1,1));
    ASSERT_EQ(false, is_bit_set(1,2));
    ASSERT_EQ(true, is_bit_set(3,2));
    ASSERT_EQ(true, is_bit_set(2,3));
}