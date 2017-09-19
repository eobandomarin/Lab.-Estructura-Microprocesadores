;------------------------Imprime sin cambio de linea----------------
%macro imprimir_texto 2 	;recibe 2 parametros
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,%1	;primer parametro: Texto
	mov rdx,%2	;segundo parametro: Tamano texto
	syscall
%endmacro
;------------------------- FIN DE MACRO --------------------------------

;--------------------Imprime con cambio de linea------------------------
%macro imprimir_linea 2 	;recibe 2 parametros
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,%1	;primer parametro: Texto
	mov rdx,%2	;segundo parametro: Tamano texto
	syscall
  mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,cons_nueva_linea	;primer parametro: Texto
	mov rdx,1	;segundo parametro: Tamano texto
	syscall
%endmacro
;------------------------- FIN DE MACRO --------------------------------


;------------------Dar vuelta al registro---------------------
%macro dar_vuelta 0 ;no recibe parametros ya que solo es para darle
mov r10, r9								;Toma el registro al que se le desea dar vuelta
mov r8, 0x8								;Le da el valor de 8 al r8 para usarlo como contador
mov r9, 0									;Limpia el registro
loop_1:
	shl r9, 4								;Corre los datos del registro 4 bits a la iszquierda ya que aqui se guardara el registro al reves
	mov r12, r10						;Toma el registro que se le quiere dar vuelta y hace una copia del dato
	and r12, 0x0000000f			;Se filtran los primeros 4 bits del dato a dar vuelta
	shr r10, 4							;Corre el dato 4 bits a la derecha porque ya no son necesarios
	add r9, r12							;Agrega al registro el dato filtrado
	dec r8									;Decrementa el contador
	jnz loop_1							;Regresa a la etiqueta si no se cumple la codicion
%endmacro


;------------------------Imprime un registro entero---------------------

%macro imprimir_reg 0 	;No recibe parametros
	;Para imprimir los 64 bits como caracteres ASCII se debe hacer un loop.
	;Los 64 bits almacenan 8 nibbles, osea que se debe repetir 8 veces.
	;Para hacer las repeticiones, usamos el registro R8
	mov r8,0x8
	loop_4:
		mov r10,r9									;lookup con XLAT
		and r10,0x0000000f
		mov rdx,r10
		lea ebx,[tabla]
		mov al,dl
		xlat												;Cada nibble se mueve a una direccion de memoria
		mov [cuatro],ax							;y el contenido se imprime
		mov rax,1										;sys_write
		mov rdi,1										;std_out
		mov rsi,cuatro							;primer parametro: Texto
		mov rdx,1										;segundo parametro: Tamano texto
		syscall
		shr r9,4										;shift r9 en 4 bits a la derecha para movernos al siguiente nibble
		;Decrementar el contador almacenado en CL. Cuando se llega a cero, se termina
		;la ejecucion de la macro
		dec r8
		jnz loop_4
%endmacro

section .data
  cons_nueva_linea: db 0xa
  tabla: db "0123456789ABCDEF", 0
  porcentaje: db 'Porcentaje: '
  tam_por: equ $-porcentaje
  punto: db ' %.'
  tam_punto: equ $-punto

section .bss
  direccion: resd 32
  cuatro: resd 1

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
  mov r9, rax
  imprimir_texto porcentaje, tam_por
  dar_vuelta
  imprimir_reg
  imprimir_linea punto, tam_punto

  mov rax, 60
	mov rdi, 0
	syscall
