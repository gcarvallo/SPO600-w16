.text
.globl _start

start = 10
max = 10

_start:

	mov $start, %r15 /* counter */
loop:
        movq $len, %rdx /* length */
	movq $msg, %rsi /* msg location */
	movq $1, %rdi
	movq $1, %rax   /* write syscall */
	syscall


	movq $0, %rdi   /* exit code block */
	movq $60, %rax
	syscall

.section .data

msg: .ascii "Loop:   \n"
len = . - msg
