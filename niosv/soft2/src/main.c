#include <stdint.h>

#define PIO_BASE 0x00020040

volatile uint32_t * const pio = (volatile uint32_t *)PIO_BASE;

int main(void)
{
    uint32_t a = 10;
    uint32_t b = 20;
    uint32_t c;

    c = a + b;

    *pio = c;

    while (1);

    return 0;
}
