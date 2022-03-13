###
 # @file Multiplication.s
 # @author Vincent Marias (vmarias@mines.edu)
 # @brief Implementation of the optimized hardware multiplication algorithm.
 # @date 2022-03-13
 ##

.text
    # Arguments
    #     a1: multiplicand
    #     a2: multiplier
    # Return values
    #     a0: result (multiplicand * multiplier)
    .globl mult
    mult:
        addi sp, sp, -12      # space on stack for 3 words
        sw a1, 8(sp)          # save a1
        sw a2, 4(sp)          # save a2
        sw a3, 0(sp)          # save a3

        # a0 is lower half of product
        add a0, zero, a2      # copy multiplier into lower half of product
        # a3 is upper half of product
        add a3, zero, zero    # fill upper half of product with 0s

        add t0, zero, zero    # loop counter starts at 0
        add t1, zero, zero    # used in loop to hold product LSB (of lower)
        add t2, zero, zero    # used in loop to hold product LSB (of upper)
        addi t3, zero, 32     # used for loop comparison

        mult_loop:
            bge t0, t3, mult_done               # loop comparison

            andi t1, a0, 1                      # get product LSB (of lower)

            beq t1, zero, mult_loop_continue    # test lower product LSB
            add a3, a3, a1                      # upper product += multiplicand

            mult_loop_continue:
                # next 4 instructions shift 64-bit product right 1 bit
                slli t2, a3, 31        # t2 has LSB of upper product in it's MSB
                srli a0, a0, 1         # shift lower product right 1 bit
                or a0, a0, t2          # place LSB of upper in MSB of lower
                srli a3, a3, 1         # shift upper product right 1 bit

                addi t0, t0, 1         # increment loop counter
                jal zero, mult_loop    # jump to start of loop

        mult_done:
            lw a3, 0(sp)        # restore a3
            lw a2, 4(sp)        # restore a2
            lw a1, 8(sp)        # restore a1
            addi sp, sp, 12     # pop stack frame

            jalr zero, ra, 0    # return to caller
