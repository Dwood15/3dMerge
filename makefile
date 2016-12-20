all: main

main: main.o write.o
	gcc -o test.out main.o write.o

write.o: write.s
	as -o $@ $<

main.o: main.s 
	as -o $@ $<
clean:
	rm -vf main *.o

