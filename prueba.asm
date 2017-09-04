;imprime sin cambio de linea
%macro imprimir_texto 2 	;recibe 2 parametros
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,%1	;primer parametro: Texto
	mov rdx,%2	;segundo parametro: Tamano texto
	syscall
%endmacro

;imprime con cambio de linea
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

%macro dar_vuelta 0 ;no recibe parametros ya que solo es para darle
mov r10, r9					;vuelta al registro
mov r8, 0x8
loop_1:
	shl r9, 4
	mov r11, r10
	and r11, 0x0000000f
	shr r10, 4
	add r9, r11
	dec r8
	jnz loop_1
%endmacro

;-----------------------------------------------------------------------
%macro imprimir_reg 0 	;No recibe parametros
	;Para imprimir los 64 bits como caracteres ASCII se debe hacer un loop.
	;Los 64 bits almacenan 8 nibbles, osea que se debe repetir 8 veces.
	;Para hacer las repeticiones, usamos el registro R8
	mov r8,0x8
	loop:
		mov r10,r9
		;lookup con XLAT
		and r10,0x0000000f
		mov rdx,r10
		lea ebx,[tabla]
		mov al,dl
		xlat
		;Cada nibble se mueve a una direccion de memoria
		mov [cuatro],ax
		;y el contenido se imprime
		mov rax,1	;sys_write
		mov rdi,1	;std_out
		mov rsi,cuatro	;primer parametro: Texto
		mov rdx,1	;segundo parametro: Tamano texto
		syscall
		;shift r9 en 4 bits a la derecha para movernos al siguiente nibble
		shr r9,4
		;Decrementar el contador almacenado en CL. Cuando se llega a cero, se termina
		;la ejecucion de la macro
		dec r8
		jnz loop
%endmacro
;------------------------- FIN DE MACRO --------------------------------

%macro dar_vuelta2 0 ;no recibe parametros ya que solo es para darle
mov r10, r9					;vuelta al registro
mov r8, 0x8
loop_3:
	shl r9, 4
	mov r11, r10
	and r11, 0x0000000f
	shr r10, 4
	add r9, r11
	dec r8
	jnz loop_3
%endmacro

;-----------------------------------------------------------------------
%macro imprimir_reg2 0 	;No recibe parametros
	;Para imprimir los 64 bits como caracteres ASCII se debe hacer un loop.
	;Los 64 bits almacenan 8 nibbles, osea que se debe repetir 8 veces.
	;Para hacer las repeticiones, usamos el registro R8
	mov r8,0x8
	loop_2:
		mov r10,r9
		;lookup con XLAT
		and r10,0x0000000f
		mov rdx,r10
		lea ebx,[tabla]
		mov al,dl
		xlat
		;Cada nibble se mueve a una direccion de memoria
		mov [cuatro],ax
		;y el contenido se imprime
		mov rax,1	;sys_write
		mov rdi,1	;std_out
		mov rsi,cuatro	;primer parametro: Texto
		mov rdx,1	;segundo parametro: Tamano texto
		syscall
		;shift r9 en 4 bits a la derecha para movernos al siguiente nibble
		shr r9,4
		;Decrementar el contador almacenado en CL. Cuando se llega a cero, se termina
		;la ejecucion de la macro
		dec r8
		jnz loop_2
%endmacro
;------------------------- FIN DE MACRO --------------------------------


section .data
  cons_nueva_linea: db 0xa
  tabla: db "0123456789ABCDEF",0
  fabricante: db 'Fabricante: '
  tam_fabricante: equ $-fabricante
  modelo: db 'Modelo: 0x'
  tam_modelo: equ $-modelo
  familia: db 'Familia: 0x'
  tam_familia: equ $-familia
  frecuencia: db 'Frecuencia: '
  tam_frecuencia: equ $-frecuencia
	ram_memoria: db 'Cantidad de memria RAM: 0x'
	tam_ram_memoria: equ $-ram_memoria
	ram_disponible: db 'Memoria RAM disponible: 0x'
	tam_ram_disponible: equ $-ram_disponible

section .bss
  fabricante_id: resd 12
  cuatro: resd 1
	frecuencia_id: resd 64
	memoria_ram: resd 56

section .text
    global _start
		global _parada1
		global _parada2
		global _parada3
		global _parada4

_start:

  mov eax, 0          ;para la infor del fabricante
  cpuid
  mov [fabricante_id], ebx
  mov [fabricante_id+4], edx
  mov [fabricante_id+8], ecx
  imprimir_texto fabricante, tam_fabricante
  imprimir_linea fabricante_id, 12


  imprimir_texto modelo, tam_modelo       ;para la infor del modelo
  mov eax, 1
  cpuid
  mov r8 , rax
  mov edx, eax
  and edx, 0x00f0
  shr edx, 4
  lea ebx, [tabla]
  mov al, dl
  xlat
  mov [cuatro], ax
  imprimir_linea cuatro, 1


  imprimir_texto familia, tam_familia       ;para la infor de familia
  mov rax,r8
  mov edx, eax
  and edx, 0x0f00
  shr edx, 8
  lea ebx, [tabla]
  mov al, dl
  xlat
  mov [cuatro], ax
  imprimir_linea cuatro, 1

	mov rax, 0x80000004				;Info de la frecuenca de operacion
	cpuid
	mov [frecuencia_id ], ecx
	mov [frecuencia_id + 32], edx
	imprimir_texto frecuencia, tam_frecuencia
	imprimir_linea frecuencia_id, 64

	nop												;informacion de la memoria ram total
	mov r8, 0
	mov rdi, memoria_ram
	mov rax, 0x63
	syscall
	mov r9, [memoria_ram + 32]
	mov r8, [memoria_ram + 33]
	and r8, 0x0f000000
	shr r8, 32
	add r8, r9
	imprimir_texto ram_memoria, tam_ram_memoria

	mov rax,r8
  mov edx, eax
  and edx, 0x000f
  lea ebx, [tabla]
  mov al, dl
  xlat
  mov [cuatro], ax
	imprimir_texto cuatro, 1
	dar_vuelta
	imprimir_reg
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,cons_nueva_linea	;primer parametro: Texto
	mov rdx,1	;segundo parametro: Tamano texto
	syscall

	mov r9, 0
	mov r8, 0
	mov r9, [memoria_ram + 40]				;info sobre la memoria_ram disponible
	mov r8, [memoria_ram + 41]
	_parada1:
	and r8, 0x0f000000
	shr r8, 32
	add r8, r9
	imprimir_texto ram_disponible, tam_ram_disponible
	mov rax,r8
  mov edx, eax
  and edx, 0x000f
  lea ebx, [tabla]
  mov al, dl
  xlat
  mov [cuatro], ax
	imprimir_texto cuatro, 1
	dar_vuelta2
	imprimir_reg2
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,cons_nueva_linea	;primer parametro: Texto
	mov rdx,1	;segundo parametro: Tamano texto
	syscall

  mov rax,60
	mov rdi,0
	syscall
