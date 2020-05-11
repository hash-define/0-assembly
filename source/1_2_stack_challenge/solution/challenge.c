#include <stdio.h>
#include <stdlib.h>

void recursive_read(void)
{
	int c = getchar();
	if (c == -1 || c == '\n')
		return;
	recursive_read();
	putchar(c);
}


int main( int argc, char *argv[] )
{
    recursive_read();
	putchar('\n');
    return EXIT_SUCCESS;
}
