//From in-class presentation.
.set O_WRONLY, 1
.set O_RDONLY, 0
.set O_CREAT, 64

.set S_IRUSR, 0400
.set S_IWUSR, 0200

.set STDIN, 0
.set STDOUT, 1

.set READ, 3
.set WRITE, 4
.set OPEN, 5
.set CLOSE, 6

.data
//filename:
//	.asciz "to_write.jms"
//to_write:
//	.ascii "Writing to file\n"

.text
.global _load_file
_load_file:
//TODO: Save all callee-save registers
	ldr r0, =filename
	mov r1, #(O_WRONLY)
	mov r2, #(S_IRUSR | S_IWUSR)
	mov r7, #OPEN
	svc #0 //Open the file for writing/reading

	cmp r0, #-1 //Did we fail in opening the file?
	beq skip
	push {r0}

read:
	ldr r1, =to_print_text_write_file
	mov r2, #24
	mov r7, #READ
	svc #0

close:
	pop {r0} //The file handle.
	mov r7, #CLOSE
	svc #0

skip:
	mov r7, #1
	svc #0
	bx lr