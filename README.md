### CSCI 341 - Computer Organization (Spring 2022)
# Multiplication

1) Include YOUR NAME and the names of all people who helped/collaborated as per the syllabus and CS@Mines collaboration policy. [This is an individual assignment]

    Vincent Marias

<br>

2) Pseudocode (in C) for your implementation.

    ```c
    /**
    * @brief multiplies two unsigned 32-bit integers, placing the lower 32 bits of
    * the result in the passed pointer location
    *
    * @param a1 multiplicand
    * @param a2 multiplier
    * @param a0 lower 32 bits of the 64-bit result (will be overwritten)
    */
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
    ```

<br>

3) Describe the challenges you encountered and how you surmounted them.

- The biggest challenge for me was first understanding how the optimized algorithm actually works. I had to read through the section in the textbook carefully and examine the diagrams.

- To make this assignment easier, I made sure to write my C code such that it resembled the assembly instructions as closely as possible. I even used this register names as variable names. This was an effective strategy.

<br>

4) What did you like about the assignment?

- I liked learning this algorithm; I think it's super clever.

- I also liked that this assignment was very straightforward. It wasn't exactly easy, but the instructions were very clear and I knew how to go about solving it.

<br>

5) How long did you spend working on this assignment?

    ~2.5 hours

<br>

6) A description of any features you added for extra credit (if any)

    N/A
