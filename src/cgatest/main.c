#include <dos.h>
#include <i86.h>

unsigned char *VIDEO = (char*)0xB8000;

void set_video_mode() {
    union REGS inregs;
    union REGS outregs;

    /* ah = 00h, int 16h "read key stroke" */
    // http://www.wagemakers.be/english/doc/vga
    inregs.h.ah = 0x0; // change screen resolution
    inregs.h.al = 0x6; // 640x200
    int86(0x10, &inregs, &outregs);
}

void plot_pixel(int x, int y, unsigned char color) {
    VIDEO[(y * 640) + x] = color;
}

int main() {
    int x, y;

    set_video_mode();

    for (x = 0; x < 256; x++) {
        for (y = 0; y < 50; y++) {
            VIDEO[640 + 50 + y] = x;
        }
    }

    sleep(3);

    return 0;
}
