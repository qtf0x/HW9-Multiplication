/**
 * @file Multiplication.c
 * @author Vincent Marias (vmarias@mines.edu)
 * @brief Implementation of the optimized hardware multiplication algorithm.
 * @date 2022-03-13
 */

#include <inttypes.h>
#include <stdio.h>

/**
 * @brief multiplies two unsigned 32-bit integers, placing the lower 32 bits of
 * the result in the passed pointer location
 *
 * @param a1 multiplicand
 * @param a2 multiplier
 * @param a0 lower 32 bits of the 64-bit result (will be overwritten)
 */
void mult(uint32_t a1, uint32_t a2, uint32_t* a0);

int main() {
    char arrayNumberPrompt[] = "Enter a number: ";
    char multPrompt[] = "Mult Result: ";

    uint32_t a0 = 0;
    uint32_t a1 = 0;
    uint32_t a2 = 0;

    printf("%s", arrayNumberPrompt);
    scanf("%" SCNd32, &a1);

    printf("%s", arrayNumberPrompt);
    scanf("%" SCNd32, &a2);

    mult(a1, a2, &a0);
    printf("%s%d\n", multPrompt, a0);

    return 0;
}

void mult(uint32_t a1, uint32_t a2, uint32_t* a0) {
    // a0 is lower half of product
    *a0 = a2;
    // a3 is upper half of product
    uint32_t a3 = 0;

    uint32_t t1 = 0;
    uint32_t t2 = 0;
    for (int t0 = 0; t0 < 32; ++t0) {
        // get LSB of product
        t1 = *a0 & 1;

        // test LSB of product
        if (t1)
            a3 += a1;

        // shift product right 1 bit
        t2 = a3 << 31;
        *a0 >>= 1;
        *a0 |= t2;
        a3 >>= 1;
    }
}
