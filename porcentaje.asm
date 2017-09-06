section .bss
  direccion: resd 32

section .text
  global _start
  
_start:
  nop
  mov rdi, direccion        ;se da la direccion de memoria para guardar
  mov rax, 0x63             ; el struct con los datos necesarios
  syscall
  mov r8, [direccion + 8]   ; se toman los bytes apartir del 9 en adelante, el cual es la carga del procesador en el ultimo minuto
  mov rax, 0x64             ;se le da el valor de 100 decimal al registro
  mul r8                    ; se multiplica el valor obtenido de la direccion de memoria por 100 decimal
  mov r8, 0xffff            ; se le da el valor de 0xffff
  div r8                    ; se divide el resultado de la mutiplicacion entre 0xffff

  mov rax, 60
	mov rdi, 0
	syscall
