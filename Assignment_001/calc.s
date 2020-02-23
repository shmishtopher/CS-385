# @author   Shmish
# @version  2.6.2020
# @licence  MIT


  .data
int_small:  .word 0
int_large:  .word 0
prompt_a:   .asciiz "Enter first integer: "
prompt_b:   .asciiz "Enter second integer: "
label_a:    .asciiz "First integer: "
label_b:    .asciiz "Second integer: "
label_c:    .asciiz "Quotient: "
label_d:    .asciiz "Remainder: "
newline:    .asciiz "\n"

  .text
  .globl main

main:
  ori   $2, $0, 0x04    # Syscall 0x04 - Print string
  lui   $4, 0x1001      # Point to prompt_a
  ori   $4, $4, 0x08    # Point to prompt_a
  syscall

  ori   $2, $0, 0x05    # Syscall 0x05 - Read integer
  syscall

  addu  $8, $0, $2      # Move the data

  ori   $2, $0, 0x04    # Syscall 0x04 - Print string
  lui   $4, 0x1001      # Point to prompt_b
  ori   $4, $4, 0x1E    # Point to prompt_b
  syscall

  ori   $2, $0, 0x05    # Syscall 0x05 - Read integer
  syscall

  addu  $9, $0, $2      # Move the data

  sub		$10, $8, $9     # $10 = $8 - $9
  lui   $11, 0x1001     # Point to int_small
  lui   $12, 0x1001     # Point to int_large
  bgtz  $10, agtb       # Jump to agtb
  ori   $12, $12, 0x04  # Point to int_large during delay slot

#bgta:
  sw    $8, 0($11)      # Store a in int_small
  j divide              # Jump to divide
  sw    $9, 0($12)      # Store b in int_large during delay slot

agtb:
  sw		$8, 0($12)		  # Store a in int_large
  sw    $9, 0($11)      # Store b in int_small

divide:
  lw    $8, 0($11)      # Load smaller int into $8
  lw    $9, 0($12)      # Load larger int into $9
  ori   $0, $0, 0x00    # no-op

  div   $9, $8          # Divide larger int by smaller int
  mflo  $10             # Move quotient into $10
  mfhi  $11             # Move remainder into $11

  ori   $2, $0, 0x04    # Syscall 0x04 - Print string
  lui   $4, 0x1001      # Point to label_a
  ori   $4, $4, 0x35    # Point to label_a
  syscall

  ori   $2, $0, 0x01    # Syscall 0x01 - Print integer
  addu  $4, $9, $0      # Move $9 into $4
  syscall

  ori   $2, $0, 0x04    # Syscall 0x04 - Print string
  lui   $4, 0x1001      # Point to newline
  ori   $4, $4, 0x6D    # Point to newline
  syscall

  ori   $2, $0, 0x04    # Syscall 0x04 - Print string
  lui   $4, 0x1001      # Point to label_b 
  ori   $4, $4, 0x45    # Point to label_b
  syscall

  ori   $2, $0, 0x01    # Syscall 0x01 - Print integer
  addu  $4, $8, $0      # Move $8 into $4
  syscall

  ori   $2, $0, 0x04    # Syscall 0x04 - Print string
  lui   $4, 0x1001      # Point to newline
  ori   $4, $4, 0x6D    # Point to newline
  syscall

  ori   $2, $0, 0x04    # Syscall 0x04 - Print string
  lui   $4, 0x1001      # Point to label_c 
  ori   $4, $4, 0x56    # Point to label_c
  syscall

  ori   $2, $0, 0x01    # Syscall 0x01 - Print integer
  addu  $4, $10, $0     # Move $10 into $4
  syscall

  ori   $2, $0, 0x04    # Syscall 0x04 - Print string
  lui   $4, 0x1001      # Point to newline
  ori   $4, $4, 0x6D    # Point to newline
  syscall

  ori   $2, $0, 0x04    # Syscall 0x04 - Print string
  lui   $4, 0x1001      # Point to label_d 
  ori   $4, $4, 0x61    # Point to label_d
  syscall

  ori   $2, $0, 0x01    # Syscall 0x01 - Print integer
  addu  $4, $11, $0     # Move $11 into $4
  syscall

  ori   $2, $0, 0x04    # Syscall 0x04 - Print string
  lui   $4, 0x1001      # Point to newline
  ori   $4, $4, 0x6D    # Point to newline
  syscall

  ori   $2, $0, 0x0A    # Syscall 0x0A - Exit program
  syscall