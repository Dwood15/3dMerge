.set STDOUT, 1

.set EXIT, 1
.set WRITE, 4
.set MMAP2, 192
.set MUNMAP, 91

.set PROC_READ, 1
.set PROC_WRITE, 2

.set MAP_PRIVATE, 2
.set MAP_ANONYMOUS, 32

.data
pointer:
	.word 0
.text
//r1 is LENGTH, ENSURE THAT r1 is passed!
.global _mmap
_mmap:
//.global _start
//	_start:
	mov r7, #MMAP2
	mov r0, #0
//	mov r1, #4096
//	mov r1, =length
	mov r2, #(PROC_READ | PROC_WRITE)
	mov r3, #(MAP_ANONYMOUS | MAP_PRIVATE)
	mov r4, #-1
	mov r5, #0
	svc #0
//set pointer = value in r1
	ldr r1, =pointer
//store r0 at address of r1
	str r0, [r1]
//return to calling function - the memory pointer is in r0
	bx lr

//MUNMAP.s
//	mov r7, #MUNMAP
//	ldr r0, =pointer
//	ldr r0, [r0]
//	ldr r1, =length
//	ldr r1, [r1]
//	svc #0
//.exit
//	mov r7, #EXIT
//	svc #0

