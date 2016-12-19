	.arch armv6
	.fpu vfp
	.section	.rodata
	.align	2
.value:
	.ascii	"1.53234\000"
	.align	2
.stringToPrint:
	.ascii	"Value: %f\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
//Setup the frame pointer and the stack pointers
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
//Setup the function call
	ldr	r3, .values
// By saving r3 in the frame pointer
	str	r3, [fp, #-8]
//Put that value into r0 for atof
	ldr	r0, [fp, #-8]
	bl	atof
	fstd	d0, [fp, #-20]
	ldr	r0, .values+4
	ldrd	r2, [fp, #-20]
	bl	printf
	mov	r3, #0
	mov	r0, r3
	bl _file_touch
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
//Call _file_touch
        bl _file_touch
	bx lr
.L4:
	.align	2
.values:
	.word	.value
	.word	.stringToPrint
