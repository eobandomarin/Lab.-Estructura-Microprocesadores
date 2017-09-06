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
	mov r12, r10
	and r12, 0x0000000f
	shr r10, 4
	add r9, r12
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
	mov r12, r10
	and r12, 0x0000000f
	shr r10, 4
	add r9, r12
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
		mov r10, r9
		;lookup con XLAT
		and r10, 0x0000000f
		mov rdx, r10
		lea ebx, [tabla]
		mov al, dl
		xlat
		;Cada nibble se mueve a una direccion de memoria
		mov [cuatro], ax
		;y el contenido se imprime
		mov rax, 1	;sys_write
		mov rdi, 1	;std_out
		mov rsi, cuatro	;primer parametro: Texto
		mov rdx, 1	;segundo parametro: Tamano texto
		syscall
		;shift r9 en 4 bits a la derecha para movernos al siguiente nibble
		shr r9, 4
		;Decrementar el contador almacenado en CL. Cuando se llega a cero, se termina
		;la ejecucion de la macro
		dec r8
		jnz loop_2
%endmacro
;------------------------- FIN DE MACRO --------------------------------


;-----------------------------------------------------------------------
%macro imprimir_reg3 0 	;No recibe parametros
	;Para imprimir los 64 bits como caracteres ASCII se debe hacer un loop.
	;Los 64 bits almacenan 8 nibbles, osea que se debe repetir 8 veces.
	;Para hacer las repeticiones, usamos el registro R8
	mov r8,0x8
	loop_5:
		mov r10, r9
		;lookup con XLAT
		and r10, 0x0000000f
		mov rdx, r10
		lea ebx, [tabla]
		mov al, dl
		xlat
		;Cada nibble se mueve a una direccion de memoria
		mov [cuatro], ax
		;y el contenido se imprime
		mov rax, 1	;sys_write
		mov rdi, 1	;std_out
		mov rsi, cuatro	;primer parametro: Texto
		mov rdx, 1	;segundo parametro: Tamano texto
		syscall
		;shift r9 en 4 bits a la derecha para movernos al siguiente nibble
		shr r9, 4
		;Decrementar el contador almacenado en CL. Cuando se llega a cero, se termina
		;la ejecucion de la macro
		dec r8
		jnz loop_5
%endmacro
;------------------------- FIN DE MACRO --------------------------------

; IMPRIMIR HEXA
		%macro impr_hexa 1 	;recibe 1 parametro
			mov rdx,%1
			lea ebx,[tabla]
			mov al,dl
			xlat
			mov [byte_uno],ax
			imprimir_texto byte_uno,1
		%endmacro
;------------------------------------------------------------

section .data
  cons_nueva_linea: db 0xa
  tabla: db "0123456789ABCDEF", 0
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
	unidad: db ' bytes.'
	tam_unidad: equ $-unidad
	archivo: db '/sys/block/sda/size',0
	tam_archivo: equ $-archivo
	disco: db 'Espacio total del disco duro: '
	tam_disco: equ $-disco
	cachetxt: db 'Memoria Cache: ',0xa ;Texto cache
	lencachetxt: equ $-cachetxt ;Tamano texto cache
	cnst_esp: db 0xa
	dcache: db 'D'
	dospuntos: db ': '

section .bss
  fabricante_id: resd 12
  cuatro: resd 1
	frecuencia_id: resd 64
	memoria_ram: resd 224
	contenido_archivo: resd 10
	reg_copia: resb 8
	byte_uno: resb 1

section .text
    global _start

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
  mov rax, r8
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

	mov rax, r8
  mov edx, eax
  and edx, 0x000f
  lea ebx, [tabla]
  mov al, dl
  xlat
  mov [cuatro], ax
	imprimir_texto cuatro, 1
	dar_vuelta
	imprimir_reg
	imprimir_linea unidad, tam_unidad

	mov r9, 0
	mov r8, 0
	mov r9, [memoria_ram + 40]				;info sobre la memoria_ram disponible
	mov r8, [memoria_ram + 41]
	and r8, 0x0f000000
	shr r8, 32
	add r8, r9
	imprimir_texto ram_disponible, tam_ram_disponible
	mov rax, r8
  mov edx, eax
  and edx, 0x000f
  lea ebx, [tabla]
  mov al, dl
  xlat
  mov [cuatro], ax
	imprimir_texto cuatro, 1
	dar_vuelta2
	imprimir_reg2
	imprimir_linea unidad, tam_unidad

	imprimir_texto disco, tam_disco
	mov ebx, archivo										;para obtener la memoria total del disco duro
	mov eax, 5
	mov ecx, 0
	mov edx, 0
	int 80h
	_parada1:
	mov eax,3
	mov ebx,3
	mov ecx,contenido_archivo
	mov edx, 200
	int 80h
	_parada2:
	mov r9, [contenido_archivo + 8]
	mov r13, [contenido_archivo + 9]					;vuelta al registro
	and r13, 0x0f000000
	shr r13, 32
	imprimir_reg3
	mov rax, r13
  mov edx, eax
  and edx, 0x000f
  lea ebx, [tabla]
  mov al, dl
  xlat
  mov [cuatro], ax
	imprimir_texto cuatro, 1
	imprimir_linea unidad, tam_unidad
	_parada3:

	imprimir_texto cachetxt, lencachetxt 		;Se imprime el texto de cache
	mov eax,2 								;Parametro para cache en CPUID
	cpuid										;Se obtienen los datos de cache

_datacache:									;Datos de cache listos

;--------Guardar informacion-----
	mov [reg_copia],eax						;Se guarda en reg_copia los datos de cache de eax
	mov r9,[reg_copia]						;Se guarda en r9 los datos de reg_copia

_datacachebackup:							;Datos respaldados

;---------Ciclo recorrer registro---
	mov r8,0x4								;Numero de repeticiones en r8
	mov r10,1									;Contador para numero de dato a consultar

	loopcache:								;Inicio del ciclo

		;--------Numero dato-------
		imprimir_texto dcache,1					;Se imprime D
		impr_hexa r10						;Se imprime numero de dato
		imprimir_texto dospuntos,2				;Se imprimen dos puntos

		;--Variables y mascaras--
		mov r12,r9							;Se almacena en r12 los datos de cache
		mov r13,r9							;Se almacena en r13 los datos de cache
		shr r12,4								;Shift Right a r12 para seccionar en bloques de dos bytes
		and r12,0x0F							;Mascara para r12
		and r13,0x0F							;Mascara para r13

		;------Impresion datos------
		impr_hexa r12						;Se imprime el primer byte
		impr_hexa r13						;Se imprime el segundo byte
		imprimir_texto cnst_esp,1				;Se imprime un espacio para el siguiente ciclo

		;--Datos ciclo siguiente---
		add r10,1								;Se suma 1 al contador de dato
		shr r9,8								;Shift Right de 2 bytes para preparar el siguiente bloque
		dec r8									;Se resta 1 al contador de repeticiones restantes
	jnz loopcache								;Salto al ciclo

  mov rax, 60
	mov rdi, 0
	syscall
