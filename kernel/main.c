#include "print.h"

void _start(){
    put_str("\r\nTerry_kernel\ncoox\bl");
    while(1){
        asm("hlt");
    };
}
