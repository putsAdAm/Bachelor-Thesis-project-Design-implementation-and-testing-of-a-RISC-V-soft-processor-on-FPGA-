#include "system.h"
#include "io.h"
#include <stdint.h>

int main() {

    // Variabili di esempio
    uint32_t a = 12;
    uint32_t b = 8;
    uint32_t c = 3;

    // Operazione: (a + b) * c
    uint32_t result = (a + b) * c;

    // Scrittura sul PIO a 32 bit
    IOWR(PIO_0_BASE, 0, result);

    // loop infinito per mantenere valore stabile
    while (1) {
        // niente, il valore resta sul PIO
    }

    return 0;
}