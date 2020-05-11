#include <gtest/gtest.h>
#include <windows.h>
#include <string.h>
#include <stdint.h>

extern "C" int __cdecl array_sum(int* arr, uint32_t size);

TEST(AssemblyLoop, ArraySum)
{
    int arr[0x10] = { 0 };
    for (int i = 1; i <= sizeof(arr) / sizeof(arr[0]); i++)
        arr[i-1] = i;
    
    ASSERT_EQ(136, array_sum(arr, sizeof(arr) / sizeof(arr[0])));
}
