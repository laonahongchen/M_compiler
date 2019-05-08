#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main() {
    int a, b;
    scanf("%d%d", &a, &b);
    int c = a > b;
    printf("%d\n", c);

    return 0;
}





/*!! metadata:
=== comment ===
function2.mx
=== assert ===
exitcode
=== timeout ===
0.1
=== input ===

=== phase ===
codegen pretest
=== is_public ===
True
=== exitcode ===
13

!!*/
