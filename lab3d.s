.text
.globl  _start

start = 0
max =  12
div =10
space = 32
offset = 48
_start:

	mov x19, start  /*counter */
	mov x20, div
	adr x21, msg
outerloop:
	add x19 , x19 , 1  /* add to counter */

	udiv x3 , x19, x20
	msub x4 , x3, x20, x19
	
	mov x0, x3 /*integer to convert */
	mov x1, space
	bl convert
	strb w0, [x21,1]

	mov x0, x4
	mov x1, 48
	bl convert
	strb w0, [x21, 2]

	mov x22, start	
innerloop:
	add x22, x22 ,1	
	
	udiv x3 , x22, x20
	msub x4 , x3, x20, x22


	mov x0, x3 /*integer to convert */
	mov x1, space
	bl convert
	strb w0, [x21,6]

	mov x0, x4
	mov x1, 48
	bl convert
	strb w0, [x21, 7]
	
	bl print

	cmp x22, max
	b.lt innerloop

   	mov x0, 1        /*file descriptor     */
	adr x1, lin    /* msg location */
	mov x2, linelen  /*lenght */
	mov x8, 64     /* write syscall */
	svc 0
		
	cmp x19, max
	b.lt outerloop	

	mov x0, 0   /* exit syscall code block */
	mov x8, 93
	svc 0
print:
   	mov x0, 1        /*file descriptor     */
	adr x1, msg    /* msg location */
	mov x2, len  /*lenght */
	mov x8, 64     /* write syscall */
	svc 0
	ret
convert:
	cmp x0, 0
	b.ne digit
	mov x0 , x1
	b continue
digit:
	add x0, x0, offset
continue:
	ret
		


.data
msg: .ascii "    X    =      \n"
len= . - msg
lin: .ascii "----------------------\n"
linelen = . - lin


