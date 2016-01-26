.text
.globl _start

start = 0
max = 31
offset = 48

_start:
	movq $start, %r15
	movq $10, %r13
loop:
	movq $0, %rdx
	movq %r15, %rax
	div %r13
	cmp $0, %rax
	je skip

	movq $offset , %r14 /* offset to ascii digits */
	add %rax, %r14
	movb %r14b, (msg+6) 
skip:	
	movq $offset, %r12
	add %rdx, %r12
	movb %r12b, (msg+7)

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
msg: .ascii "Loop:   \n"
len = . - msg
