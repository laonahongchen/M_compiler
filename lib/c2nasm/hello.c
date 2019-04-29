#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char s1[10];
char s2[10];
char s3[10];

int main() {
	memcpy(s1, "hello", 5);
	memcpy(s2, "world", 5);
	strcat(s1, s2);
	printf("%s\n", s1);
	
	return 0;
}