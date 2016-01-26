.text
.globl _start

start = 0
max = 10
offset = 48
_start:
	movq $start, %r15 /* counter */
loop:

	movq $offset , %r14 /* offset to ascii digits */
	add %r15, %r14
	movb %r14b, (msg+6) 


	movq $len, %rdx /* msg length */
	movq $msg, %rsi /*msg location */
	movq $1, %rdi   /* stdout */
	movq $1, %rax /* syscall */
	syscall

	inc %r15
	cmp $max, %r15
	jne loop


	movq $0, %rdi /* exit code block */
	movq $60, %rax
	syscall

.section .data
msg: .ascii "Loop:  \n"
len = . - msg
