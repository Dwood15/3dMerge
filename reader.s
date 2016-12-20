//From in-class presentation.
.set O_RDONLY, 0
.set S_IRUSR, 0400
.set S_IWUSR, 0200
.set READ, 3
.set OPEN, 5
.set CLOSE, 6

.data
filename:
	.asciz "to_write.jms"
pointer:
	.word 0
//Completely arbitrary file size max for now.
//Must be a power of two, iirc.
maxFileSize:
	.word 4096
//c_r_a must be a multple of maxFileSize
chunk_read_amount:
	.word 48

file_size_location:
	.word maxFileSize
.text
//.global _load_file
//	_load_file:
.global _start
	_start:
	ldr r1, =maxFileSize
	ldr r1, [r1] //Ensure value is in register
	mov r9, r1

	bl _mmap
	ldr r2, =pointer
	str r0, [r2]

        mov r4, r0
        mov r2, #0
        mov r0, #3
.Loop:
//store r0 in [r4], then progress one
        strb r0, [r4], #1
        add r2, r2, #1
//^^ Store r0 in r4, then increment r4 by one
.condition:
        cmp r2, r9
        blt .Loop
	ldr r2, [r1]
	//Save the returned memory location at =pointer
	//_mmap returns address in r0.
	ldr r2, =pointer
	str r0, [r2]


//TODO: Save all callee-save registers
_read_file:
	ldr r0, =filename
	mov r1, #(O_RDONLY)
	mov r2, #(S_IRUSR | S_IWUSR)
	mov r7, #OPEN
	svc #0 //Open the file for writing/reading

	cmp r0, #-1 //Did we fail in opening the file?
	beq rskip
	push {r0}

	//r5 so no register saving worries.
	//I'm lazy.
	ldr r1, =pointer
	str r0, [r1]
	mov r4, r0

	mov r0, #0
read:
	ldr r1, =chunk_read_amount
	mov r7, #READ
	svc #0
//While #READ returns > 0 bytes, we loop
condition:
	cmp r0, #0
	bgt read


close:
	pop {r0} //The file handle.
	mov r7, #CLOSE
	svc #0

rskip:
	mov r7, #1
	svc #0
	bx lr
