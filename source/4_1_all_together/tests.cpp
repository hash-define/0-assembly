#include <gtest/gtest.h>
#include <windows.h>
#include <string.h>
#include <stdint.h>

extern "C" int __cdecl count_chars(const char *buffer, size_t size);
extern "C" int __cdecl count_lines(const char *buffer, size_t size);
extern "C" int __cdecl count_words(const char *buffer, size_t size);
extern "C" int __cdecl longest_line(const char *buffer, size_t size);

TEST(CountChars, Empty)
{
    ASSERT_EQ(0, count_chars("", 0));
}

TEST(CountChars, Normal)
{
    ASSERT_EQ(4, count_chars("abcd", 4));
}

TEST(CountChars, Long)
{
    char buffer[1000];
    memset(buffer, 'A', sizeof(buffer));
    ASSERT_EQ(1000, count_chars(buffer, sizeof(buffer)));
}

TEST(CountChars, WhiteSpace)
{
    char buffer[] = "White space";
    ASSERT_EQ(sizeof(buffer)-2, count_chars(buffer, sizeof(buffer)-1));
}

TEST(CountLines, Empty)
{
    ASSERT_EQ(0, count_lines("", 0));
}

TEST(CountLines, One)
{
    char buffer[] = "A single line";
    ASSERT_EQ(1, count_lines(buffer, sizeof(buffer)-1));
}

TEST(CountLines, Many)
{
    char buffer[] = "Line One\nLineTwo\nLineThree\nLineFour";
    ASSERT_EQ(4, count_lines(buffer, sizeof(buffer)-1));
}

TEST(LongestLine, Empty)
{
    ASSERT_EQ(0, longest_line("", 0));
}

TEST(LongestLine, One)
{
    char buffer[] = "A single line.";
    ASSERT_EQ(14, longest_line(buffer, sizeof(buffer)-1));
}

TEST(LongestLine, Increasing)
{
    char buffer[] = "a\naa\naaa";
    ASSERT_EQ(3, longest_line(buffer, sizeof(buffer)-1));
}

TEST(LongestLine, Decreasing)
{
    char buffer[] = "aaa\naa\na";
    ASSERT_EQ(3, longest_line(buffer, sizeof(buffer)-1));
}

TEST(LongestLine, EmptyLine)
{
    char buffer[] = "a\n\naaa\n\na";
    ASSERT_EQ(3, longest_line(buffer, sizeof(buffer)-1));
}

TEST(LongestLine, LongLine)
{
    char buffer[1000 + 2];
    memset(buffer, 'A', sizeof(buffer));
    buffer[1000] = '\n';
    ASSERT_EQ(1000, longest_line(buffer, sizeof(buffer)));
}

TEST(CountWords, Empty)
{
    ASSERT_EQ(0, count_words("", 0));
}

TEST(CountWords, One)
{
    char buffer[] = "ASingleWord";
    ASSERT_EQ(1, count_words(buffer, sizeof(buffer)-1));
}

TEST(CountWords, Many)
{
    char buffer[] = "Not just a single word";
    ASSERT_EQ(5, count_words(buffer, sizeof(buffer)-1));
}

TEST(CountWords, FullStop)
{
    char buffer[] = "This is a sentence.";
    ASSERT_EQ(4, count_words(buffer, sizeof(buffer)-1));
}

TEST(CountWords, Hyphen)
{
    char buffer[] = "fool-proof";
    ASSERT_EQ(1, count_words(buffer, sizeof(buffer)-1));
}

TEST(CountWords, Apostrophe)
{
    char buffer[] = "don't count me twice!";
    ASSERT_EQ(4, count_words(buffer, sizeof(buffer)-1));
}

TEST(CountWords, ManyLines)
{
    char buffer[] = "Line one.\nLine Two.\nLine Three";
    ASSERT_EQ(6, count_words(buffer, sizeof(buffer)-1));
}

TEST(CountWords, TabDelimeted)
{
    char buffer[] = "One\tTwo\tThree";
    ASSERT_EQ(3, count_words(buffer, sizeof(buffer)-1));
}

TEST(CountWords, NonPrintable)
{
    char buffer[] = "One Two Three";
    buffer[3] = 0x01;
    ASSERT_EQ(3, count_words(buffer, sizeof(buffer)-1));
}


