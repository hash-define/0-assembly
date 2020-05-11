#include <gtest/gtest.h>
#include <windows.h>
#include <string.h>
#include <stdint.h>

extern "C" int __cdecl increment(int x);
extern "C" int __cdecl add(int a, int b);
extern "C" int __cdecl negate(int x);
extern "C" int __cdecl subtract(int a, int b);
extern "C" int __cdecl multiply(int a, int b);
extern "C" int __cdecl divide(int a, int b);
extern "C" int __cdecl remainder(int a, int b);

TEST(AssemblyArithmetic, Increment)
{
    ASSERT_EQ(1, increment(0));
    ASSERT_EQ(0, increment(-1));
    ASSERT_EQ(2, increment(1));
}

TEST(AssemblyArithmetic, Add)
{
    ASSERT_EQ(0, add(0, 0));
    ASSERT_EQ(2, add(1, 1));
    ASSERT_EQ(0, add(1, -1));
    ASSERT_EQ(0xCAFEBABE, add(0xCAFE << 16, 0xBABE));
}

TEST(AssemblyArithmetic, Negate)
{
    ASSERT_EQ(0, negate(0));
    ASSERT_EQ(1, negate(-1));
    ASSERT_EQ(-1, negate(1));
}

TEST(AssemblyArithmetic, Subtract)
{
    ASSERT_EQ(0, subtract(0, 0));
    ASSERT_EQ(1, subtract(1, 0));
    ASSERT_EQ(0, subtract(1,1));
    ASSERT_EQ(-1, subtract(0,1));
    ASSERT_EQ(99, subtract(100,1));
}

TEST(AssemblyArithmetic, Multiply)
{
    ASSERT_EQ(0, multiply(0, 0));
    ASSERT_EQ(0, multiply(1, 0));
    ASSERT_EQ(1, multiply(1,1));
    ASSERT_EQ(2, multiply(2,1));
    ASSERT_EQ(4, multiply(2,2));
    ASSERT_EQ(-8, multiply(4,-2));
    ASSERT_EQ(-8, multiply(-4,2));
    ASSERT_EQ(8, multiply(-4,-2));
}

TEST(AssemblyArithmetic, Divide)
{
    ASSERT_EQ(0, divide(0, 1));
    ASSERT_EQ(1, divide(1,1));
    ASSERT_EQ(2, divide(2,1));
    ASSERT_EQ(2, divide(4,2));
    ASSERT_EQ(-2, divide(4,-2));
    ASSERT_EQ(-2, divide(-4,2));
    ASSERT_EQ(2, divide(-4,-2));
    ASSERT_EQ(1, divide(3,2));
}

TEST(AssemblyArithmetic, Remainder)
{
    ASSERT_EQ(0, remainder(0, 1));
    ASSERT_EQ(1, remainder(3,2));
    ASSERT_EQ(2, remainder(5,3));
}