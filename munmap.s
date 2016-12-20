//File called when deallocating memory!
.set MUNMAP, 91
.text
//r0 is the POINTER. ensure that it is passed!
//r1 is LENGTH, ENSURE THAT r1 is passed!
.global _munmap
_munmap:

	mov r7, #MUNMAP
//	ldr r0, =pointer
	ldr r0, [r0]
//	ldr r1, =length
	ldr r1, [r1]
	svc #0
	bx lr


