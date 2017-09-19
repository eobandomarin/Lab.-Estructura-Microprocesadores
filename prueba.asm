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

%macro dar_vuelta2 0 ;no recibe parametros ya que solo es para darle
mov r10, r9
mov r8, 0x8
mov r9, 0
loop_2:
	shl r9, 4
	mov r12, r10
	and r12, 0x0000000f
	shr r10, 4
	add r9, r12
	dec r8
	jnz loop_2
%endmacro

%macro dar_vuelta3 0 ;no recibe parametros ya que solo es para darle
mov r10, r9
mov r8, 0x8
mov r9, 0
loop_3:
	shl r9, 4
	mov r12, r10
	and r12, 0x0000000f
	shr r10, 4
	add r9, r12
	dec r8
	jnz loop_3
%endmacro
;------------------------- FIN DE MACRO --------------------------------

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

%macro imprimir_reg2 0 	;No recibe parametros
	mov r8,0x8
	loop_5:
		mov r10, r9
		and r10, 0x0000000f
		mov rdx, r10
		lea ebx, [tabla]
		mov al, dl
		xlat
		mov [cuatro], ax
		mov rax, 1
		mov rdi, 1
		mov rsi, cuatro
		mov rdx, 1
		syscall
		shr r9, 4
		dec r8
		jnz loop_5
%endmacro

%macro imprimir_reg3 0 	;No recibe parametros
	mov r8,0x8
	loop_6:
		mov r10, r9
		and r10, 0x0000000f
		mov rdx, r10
		lea ebx, [tabla]
		mov al, dl
		xlat
		mov [cuatro], ax
		mov rax, 1
		mov rdi, 1
		mov rsi, cuatro
		mov rdx, 1
		syscall
		shr r9, 4
		dec r8
		jnz loop_6
%endmacro
;------------------------- FIN DE MACRO --------------------------------


;------------------------ IMPRIMIR HEXA --------------------------------
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
;Se definen los encabezados para cada dato a mostrar en pantalla
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
	disco: db 'Espacio total del disco duro: '
	tam_disco: equ $-disco
	cachetxt: db 'Memoria Cache: ',0xa ;Texto cache
	lencachetxt: equ $-cachetxt ;Tamano texto cache

	unidad: db ' bytes.'
	tam_unidad: equ $-unidad
	unidadGb: db ' GB.'
	tam_unidadGb: equ $-unidadGb
	archivo: db '/sys/block/sda/size', 0
	tam_archivo: equ $-archivo
	cnst_esp: db 0xa
	dcache: db 'D'
	dospuntos: db ': '

section .bss
;Direcciones de memoria para extraer ciertos datos requeridos
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
;-----------------------Para la informacion del fabricante----------------
  mov eax, 0      																;Se escribe el dato 0 en el registro para entrar a cierta parte de la funcion CPUID
  cpuid																						;Se llama a la funcion de informacion del CPU
  mov [fabricante_id], ebx												;Se toman las primeras letras de Genu
  mov [fabricante_id+4], edx											;Se toman las letras ineI
  mov [fabricante_id+8], ecx											;Se toman las ultimas letras ntel. Todas se guardan en direcciones de memoria de forma sucesiva
  imprimir_texto fabricante, tam_fabricante				;Imprime el encabezado de Fabricante: 0x
  imprimir_linea fabricante_id, 12								;Imprime lo que se encuantra en los primeros 12 espacio de la direccion de memoria

;----------------------Para la informacion del modelo--------------------
  imprimir_texto modelo, tam_modelo      					;Imprime el encabezado de Modelo: 0x
  mov eax, 1																			;Se escribe el dato 1 en el registro para entrar a cierta parte de la funcion CPUID
  cpuid																						;Despues de esta funcion, en ciertos registros, se cargan los datos de interes
  mov r8 , rax																		;Se hace una copia de seguridad en el registro 8
  mov edx, eax																		;Se hace una marcara de los datos tomados
  and edx, 0x00f0																	;Se filtrael numero de interes
  shr edx, 4																			;Se corre el dato a la derecha para que se acomode
  lea ebx, [tabla]																;Se carga una tabla e el registro
  mov al, dl																			;Se toma el nibble del dato tomado y se mueve
  xlat																						;Hace una comparacion del nibble que buscamos y lo que hay en la tabla, el resultado lo almacena en ax
  mov [cuatro], ax																;Guarda el dato en la direccion de memoria dada
  imprimir_linea cuatro, 1

;-----------------------Para la informacion de la familia------------------------
  imprimir_texto familia, tam_familia       			;Imprime el encabezado de Familia: 0x
  mov rax, r8																			;Se toma el la copia del registro 8
  mov edx, eax																		;Se pasa el dato a el registro rdx
  and edx, 0x0f00																	;Se filtra para tomas el tercer conjunto de nibbles
  shr edx, 8																			;Se corre 8 veces a la derecha para acomodar el dato
  lea ebx, [tabla]
  mov al, dl
  xlat
  mov [cuatro], ax
  imprimir_linea cuatro, 1

;------------------Informacion de la frecuenca de operacion----------------------
	mov rax, 0x80000004															;Se le da esta direccion al registro para entrar en una funcion especifica del siguiente llamado
	cpuid
	mov [frecuencia_id ], ecx												;Se toman los 32 bits del registro, el cual contiene un string que contiene la funcion del procesador
	mov [frecuencia_id + 32], edx										;Se toman los 32 bits del registro, pero para este caso es para tomar el bit mas sigificativo en caso de ser mayor a 2 GB
	imprimir_texto frecuencia, tam_frecuencia				;Imprime el encabezado Frecuencia: 0x
	imprimir_linea frecuencia_id, 64

;---------------------Informacion de la memoria ram total------------------------
	nop
	mov r8, 0
	mov rdi, memoria_ram
	mov rax, 0x63
	syscall
	mov r9, [memoria_ram + 32]
	mov r8, [memoria_ram + 33]
	and r8, 0x0f000000
	shr r8, 24
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
	shr r8, 24
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

	imprimir_texto disco, tam_disco					;para obtener la memoria total del disco duro
	mov ebx, archivo
	mov eax, 5
	mov ecx, 0
	mov edx, 0
	int 80h

	mov eax, 3
	mov ebx, 3
	mov ecx, contenido_archivo
	mov edx, 200
	int 80h

	mov rax, [contenido_archivo]
	mov rbx, 0x8
	mov r9, 0
	ciclo:
		shl r9, 4
		mov r8, rax
		and r8, 0x000f
		add r9, r8
		shr rax, 8
		dec rbx
		jnz ciclo
	mov r11, 1
	mov r12, 0x00
	mov r10, 0xa
	mov rbx, 0x8
	ciclo2:
		mov r8, r9
		and r8, 0x0000000f
		shr r9, 4
		mov rax, r8
		mul r11
		add r12, rax
		mov rax, r11
		mul r10
		mov r11, rax
		dec rbx
		jnz ciclo2
	mov rax, r12
	mov r8, 0x02
	div r8
	mov r8, 0x0400
	div r8
	mov r9, rax
	dar_vuelta3
	imprimir_reg3
	imprimir_linea unidadGb, tam_unidadGb

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
