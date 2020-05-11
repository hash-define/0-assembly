#include <gtest/gtest.h>
#include <windows.h>
#include <string.h>
#include <stdint.h>

extern "C" int __cdecl bitwise_and(int a, int b);
extern "C" int __cdecl bitwise_or(int a, int b);
extern "C" int __cdecl bitwise_xor(int a, int b);
extern "C" int __cdecl shift_left(int a, uint8_t x);
extern "C" int __cdecl shift_right(int a, uint8_t x);

TEST(AssemblyBitwise, BitwiseAnd)
{
    ASSERT_EQ(0, bitwise_and(0, 0));
    ASSERT_EQ(0, bitwise_and(0, 1));
    ASSERT_EQ(0, bitwise_and(1, 0));
    ASSERT_EQ(1, bitwise_and(1, 1));
    
    ASSERT_EQ(0, bitwise_and(0xff, 0));
    ASSERT_EQ(0xff, bitwise_and(0xff, 0xff));
    ASSERT_EQ(0xCAFEBABE, bitwise_and(0xCAFEBABE, 0xFFFFFFFF));
}

TEST(AssemblyBitwise, BitwiseOr)
{
    ASSERT_EQ(0, bitwise_or(0, 0));
    ASSERT_EQ(1, bitwise_or(0, 1));
    ASSERT_EQ(1, bitwise_or(1, 0));
    ASSERT_EQ(1, bitwise_or(1, 1));
    
    ASSERT_EQ(0xff, bitwise_or(0xff, 0));
    ASSERT_EQ(0xff, bitwise_or(0xaa, 0x55));
    ASSERT_EQ(0, bitwise_or(0, 0));
}

TEST(AssemblyBitwise, BitwiseXor)
{
    ASSERT_EQ(0, bitwise_xor(0, 0));
    ASSERT_EQ(1, bitwise_xor(0, 1));
    ASSERT_EQ(1, bitwise_xor(1, 0));
    ASSERT_EQ(0, bitwise_xor(1, 1));
}

TEST(AssemblyBitwise, ShiftLeft)
{
    ASSERT_EQ(0, shift_left(0, 0));
    ASSERT_EQ(1, shift_left(1, 0));
    ASSERT_EQ(2, shift_left(1,1));
    ASSERT_EQ(4, shift_left(1,2));
}

TEST(AssemblyBitwise, ShiftRight)
{
    ASSERT_EQ(0, shift_right(0, 0));
    ASSERT_EQ(1, shift_right(1, 0));
    ASSERT_EQ(0, shift_right(1,1));
    ASSERT_EQ(1, shift_right(2,1));
    ASSERT_EQ(2, shift_right(4,1));
}