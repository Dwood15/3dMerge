all: main

main: main.o write.o reader.o mmap.o
	gcc -o test.out main.o write.o reader.o mmap.o

write.o: write.s
	as -o $@ $<

reader.o: reader.s
	as -o $@ $<

mmap.o: mmap.s
	as -o $@ $<

main.o: main.s 
	as -o $@ $<
clean:
	rm -vf main *.o

