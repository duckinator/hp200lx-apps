#include <i86.h>

int main() {
    union REGS r;

    /* ah = 00h, int 16h "read key stroke" */
    // http://www.wagemakers.be/english/doc/vga
    r.h.ah = 0x0; // change screen resolution
    r.h.al = 0x6; // 640x200
    int86(0x13, &r, &r);

    return 0;
}
