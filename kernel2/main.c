#include "print.h"

void _start(){
    put_str("\r\nThis is Kernel 2, non-secure mode~~\ncoox\bl");
    while(1){
        asm("hlt");
    };
}
