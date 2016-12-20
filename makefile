all: main

main: main.o write.o reader.o mmap.o munmap.o
	gcc -o test.out main.o write.o reader.o mmap.o munmap.o

write.o: write.s
	as -o $@ $<

reader.o: reader.s
	as -o $@ $<

mmap.o: mmap.s
	as -o $@ $<

munmap.o: munmap.s
	as -o $@ $<

main.o: main.s 
	as -o $@ $<
clean:
	rm -vf main *.o

