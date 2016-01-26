.text
.globl  _start

start = 0
max = 31
div =10

_start:

	mov x19, start  /*counter */
	mov x20, div
loop:
	
   	mov x0, 1        /*file descriptor     */
	adr x1, msg    /* msg location */
	mov x2, len   /* message lenght */
	udiv x9 , x19 , x20
	msub x11, x9, x20, x19  /* calculate the reminder */

	add x10 , x9 , 48 /* convert binary into ascii */  
	strb  w10, [x1 , 6 ]  /*inserts the digit into the msg memory */

	add x11, x11 , 48 /*convert the second digit to ascii */
	strb w11, [x1, 7]

	mov x8, 64     /* write syscall */
	svc 0


	add x19, x19, 1
	cmp x19, max
	b.ne loop
	

	mov x0, 0   /* exit syscall code block */
	mov x8, 93
	svc 0

.data
msg: .ascii "loop:    \n"
len= . - msg
