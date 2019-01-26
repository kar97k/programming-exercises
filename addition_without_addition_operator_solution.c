#include <stdio.h>

static int add(int a, int b) {
	printf ("\n %d - %d",a,b);
	if (b == 0) return a;
	int puk = a ^ b;
	int puki = (a & b) << 1;
	return add(puk, puki);
}
int main()
{
	int a=21,b=18; // 0010 0101
	printf("\n%d",add(a,b));
	return 0;
}
