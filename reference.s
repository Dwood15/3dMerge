.data
.example_float_value:
	.ascii	"1.53234\000"
	.align	2
.print_float_string:
	.ascii	"Value: %f\012\000"
.example_jms_file:
	.ascii "exampledata\first.jms"
.filename:
	.ascii "to_write.jms"
.to_print_text_write_file:
	.ascii "Writing to file!\n"
.text
.Line:
	.align	2
.efv:
	.word	.example_float_value
.pfs:
	.word	.print_float_string
.ejmsf:
	.word	.example_jms_file
