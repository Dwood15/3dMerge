.data
myvar:
  .word 4
myvar2:
  .word 4
firstFile:
  .asciz "exampledata\\first.jms"
secondFile:
  .asciz "exampledata\\first.jms"
loop_with_num:
  .asciz "Looping! Loops left: %d!\n"
helloworld:
  .asciz "Hello world!"

return: .word 0
  .text
  .global loop_choice
//initial function - r4 is my register
loop_choice:
  sub sp, sp, #8
  str lr, [sp]
  sub sp, sp, #8
  str r4, [sp] //save the callee-save registers, and expand the stack
  cmp r1, #1
  ldr r0, addr_hello
  movs r5, r0
  movs r4, r1
  movs r0, r5 //Want to save the value. Consider eliminating this instruction
  bge loop_puts
loop_pf:
  bl printf
  subs r4, r4, #1
  cmp r4, #0
  bgt loop_pf
  bl end //exit the function

//loop start
loop_puts:
  bl puts
  subs r4, r4, #1
  cmp r4, #0
  bgt loop_puts
  //end of loop
end:
  ldr r4, [sp] //load saved registers,
  add sp, sp, #8
  ldr lr, [sp]
  add sp, sp, #8
  bx lr
  //end of loop_choice function

.global main
main:
  ldr r1, =firstFile
  bx _load_file

//Some string stuff...
  ldr r1, addr_return
  str lr, [r1]

  //Loop 3 times, FOR LOOP
  mov r1, #3
  mov r2, #1
//Call the 'secondary' function
  bl loop_choice
//Print the two separately...

  ldr r1, addr_return
  ldr lr, [r1]
  bx lr
//svc #0

addr_myvar: .word  myvar
addr_hello:  .word helloworld
addr_loop_with_num: .word loop_with_num
addr_return:   .word return

/*extern*/
.global printf
.global puts
