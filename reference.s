//File reading
.set O_WRONLY, 1
.set O_RDONLY, 0
.set O_CREAT, 64

.set S_IRUSR, 0400
.set S_IWUSR, 0200

//file read/writing
.set READ, 3
.set WRITE, 4
.set OPEN, 5
.set CLOSE, 6


//Generic/Global names
.set STDIN, 0
.set STDOUT, 1
.set EXIT, 1

//MMAP specific
.set MMAP2, 192
.set MUNMAP, 91

.set PROC_READ, 1
.set PROC_WRITE, 2

.set MAP_PRIVATE, 2
.set MAP_ANONYMOUS, 32
//----------------
.data
.example_float_value:
	.ascii	"1.53234\000"
	.align	2
.print_float_string:
	.ascii	"Value: %f\012\000"
.example_jms_file:
	.ascii "exampledata\first.jms"
.global filename
.filename:
	.ascii "to_write.jms"
.global to_print_text_write_file
.to_print_text_write_file:
	.ascii "Writing to file!\n"
.region_front:
	.word 1
.region_rear:
	.word 2
.text
.Line:
	.align	2
.efv:
	.word	.example_float_value
.pfs:
	.word	.print_float_string
.ejmsf:
	.word	.example_jms_file
.compatible_region_pair:
	.word .region_front
	.word .region_rear
