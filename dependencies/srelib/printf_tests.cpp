#include <gtest/gtest.h>
#include <srelib/srelib.h>

TEST(Srelib, Printf)
{
    char *ptr = "Hello, World!";
    char buf[80];
    SreLibSprintf(buf, "%s\n", ptr);
    ASSERT_STREQ("Hello, World!\n", buf);
    
    SreLibSprintf(buf, "%s\n", nullptr);
    ASSERT_STREQ("(null)\n", buf);

    SreLibSprintf(buf, "%d == 5\n", 5);
    ASSERT_STREQ("5 == 5\n", buf);
    
    SreLibSprintf(buf, "signed %d, unsigned %u, hex %x\n", -31, -31, -31);
    ASSERT_STREQ("signed -31, unsigned 4294967265, hex ffffffe1\n", buf);

    SreLibSprintf(buf, "ptr: %X padded: %04x\n", 0xCAFEBABE, 10);
    ASSERT_STREQ("ptr: CAFEBABE padded: 000a\n", buf);
    
    SreLibSprintf(buf, "'%c' == 'a'\n", 'a');
    ASSERT_STREQ("'a' == 'a'\n", buf);

    SreLibSprintf(buf, "justif: '%-10s'\n", "left");
    ASSERT_STREQ("justif: 'left      '\n", buf);
    SreLibSprintf(buf, "justif: '%10s'\n", "right");
    ASSERT_STREQ("justif: '     right'\n", buf);
}
