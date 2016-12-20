//From class example
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
length:
	.word 4096

.text
.global _start
_start:
	mov r7, #MMAP2
	mov r0, #0
	mov r1, #4096
	mov r2, #(PROC_READ | PROC_WRITE)
	mov r3, #(MAP_ANONYMOUS | MAP_PRIVATE)
	mov r4, #-1
	mov r5, #0
	svc #0

	ldr r1, =pointer
	str r0, [r1]

	mov r4, r0
	mov r0, #'0'

.Loop:
	strb r0, [r4], #1
	add r0, r0, #1
.Loop_condition:
	cmp r0, #('z' + 1)
	blt .Loop

	mov r0, #STDOUT
	ldr r1, =pointer
	ldr r1, [r1]
	sub r2, r4, r1
	mov r7, #WRITE
	svc #0

	mov r7, #MUNMAP
	ldr r0, =pointer
	ldr r0, [r0]
	ldr r1, =length
	ldr r1, [r1]
	svc #0

	mov r7, #EXIT
	svc #0
