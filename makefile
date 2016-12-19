all: atof

atof: atof.o
	gcc -o $@ $+

atof.o: atof.s 
	as -o $@ $<
clean:
	rm -vf atof *.o

