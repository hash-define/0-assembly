#include <gtest/gtest.h>
#include <windows.h>
#include <string.h>
#include <stdint.h>

extern "C" void __cdecl memory_set(uint8_t *dst, uint8_t val, uint32_t size);
extern "C" uint8_t* __cdecl memory_scan(uint8_t *haystack, uint8_t needle, uint32_t size);
extern "C" void __cdecl memory_copy(uint8_t *dst, uint8_t *src, uint32_t size);
extern "C" int __cdecl int_array_index(int *array, int index);

TEST(AssemblyMemory, MemorySet)
{
    uint8_t buffer[0x10] = { 0 };
    memory_set(buffer, 0xAA, sizeof(buffer) / sizeof(buffer[0]));
    
    for (int i = 0; i < sizeof(buffer) / sizeof(buffer[0]); i++)
        ASSERT_EQ(buffer[i], 0xAA);
    
}

TEST(AssemblyMemory, MemoryScan)
{
    uint8_t buffer[0x10] = { 0 };
    buffer[0x8] = 1;
    uint8_t *ptr = memory_scan(buffer, 0x1, sizeof(buffer) / sizeof(buffer[0]));
    ASSERT_EQ(ptr, buffer + 0x8);
}

TEST(AssemblyMemory, MemoryCopy)
{
    uint8_t src[0x10] = { 0 };
    uint8_t dst[0x10] = { 0 };
    
    for (int i = 0; i < sizeof(src) / sizeof(src[0]); i++)
        src[i] = i;
    
    memory_copy(dst, src, sizeof(src) / sizeof(src[0]));
    for (int i = 0; i < sizeof(dst) / sizeof(dst[0]); i++)
        ASSERT_EQ(dst[i], i);
}

TEST(AssemblyMemory, IntArrayIndex)
{
    int arr[0x10] = { 0 };
    
    for (int i = 0; i < sizeof(arr) / sizeof(arr[0]); i++)
        arr[i] = i+1;
    
    for (int i = 0; i < sizeof(arr) / sizeof(arr[0]); i++)
        ASSERT_EQ(i + 1, int_array_index(arr, i));
}