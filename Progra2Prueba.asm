; MACROS




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
		mov [ano],ax
		;y el contenido se imprime
		mov rax,1	;sys_write
		mov rdi,1	;std_out
		mov rsi,ano;primer parametro: Texto
		mov rdx,1	;segundo parametro: Tamano texto


		syscall

		;shift r9 en 4 bits a la derecha para movernos al siguiente nibble
		shr r9,4
		;Decrementar el contador almacenado en CL. Cuando se llega a cero, se termina
		;la ejecucion de la macro
		dec r8
		jnz loop
%endmacro


%macro dar_vuelta1 0 ;no recibe parametros ya que solo es para darle
mov r10, r9					;vuelta al registro
mov r8, 0x8
loop_11:
	shl r9, 4
	mov r12, r10
	and r12, 0x0000000f
	shr r10, 4
	add r9, r12
	dec r8
	jnz loop_11
%endmacro
%macro imprimir_reg1 0 	;No recibe parametros
	;Para imprimir los 64 bits como caracteres ASCII se debe hacer un loop.
	;Los 64 bits almacenan 8 nibbles, osea que se debe repetir 8 veces.
	;Para hacer las repeticiones, usamos el registro R8
	mov r8,0x8
	loop1:
		mov r10,r9
		;lookup con XLAT
		and r10,0x0000000f
		mov rdx,r10
		lea ebx,[tabla]
		mov al,dl
		xlat
		;Cada nibble se mueve a una direccion de memoria
		mov [mes],ax
		;y el contenido se imprime
		mov rax,1	;sys_write
		mov rdi,1	;std_out
		mov rsi,mes;primer parametro: Texto
		mov rdx,1	;segundo parametro: Tamano texto
		syscall
		;shift r9 en 4 bits a la derecha para movernos al siguiente nibble
		shr r9,4
		;Decrementar el contador almacenado en CL. Cuando se llega a cero, se termina
		;la ejecucion de la macro
		dec r8
		jnz loop1
%endmacro

%macro dar_vuelta2 0 ;no recibe parametros ya que solo es para darle
mov r10, r9					;vuelta al registro
mov r8, 0x8
loop_12:
	shl r9, 4
	mov r12, r10
	and r12, 0x0000000f
	shr r10, 4
	add r9, r12
	dec r8
	jnz loop_12
%endmacro
%macro imprimir_reg2 0 	;No recibe parametros
	;Para imprimir los 64 bits como caracteres ASCII se debe hacer un loop.
	;Los 64 bits almacenan 8 nibbles, osea que se debe repetir 8 veces.
	;Para hacer las repeticiones, usamos el registro R8
	mov r8,0x8
	loop2:
		mov r10,r9
		;lookup con XLAT
		and r10,0x0000000f
		mov rdx,r10
		lea ebx,[tabla]
		mov al,dl
		xlat
		;Cada nibble se mueve a una direccion de memoria
		mov [dia],ax
		;y el contenido se imprime
		mov rax,1	;sys_write
		mov rdi,1	;std_out
		mov rsi,dia;primer parametro: Texto
		mov rdx,1	;segundo parametro: Tamano texto
		syscall
		;shift r9 en 4 bits a la derecha para movernos al siguiente nibble
		shr r9,4
		;Decrementar el contador almacenado en CL. Cuando se llega a cero, se termina
		;la ejecucion de la macro
		dec r8
		jnz loop2
%endmacro
%macro dar_vuelta3 0 ;no recibe parametros ya que solo es para darle
mov r10, r9					;vuelta al registro
mov r8, 0x8
loop_13:
	shl r9, 4
	mov r12, r10
	and r12, 0x0000000f
	shr r10, 4
	add r9, r12
	dec r8
	jnz loop_13
%endmacro
%macro imprimir_reg3 0 	;No recibe parametros
	;Para imprimir los 64 bits como caracteres ASCII se debe hacer un loop.
	;Los 64 bits almacenan 8 nibbles, osea que se debe repetir 8 veces.
	;Para hacer las repeticiones, usamos el registro R8
	mov r8,0x8
	loop3:
		mov r10,r9
		;lookup con XLAT
		and r10,0x0000000f
		mov rdx,r10
		lea ebx,[tabla]
		mov al,dl
		xlat
		;Cada nibble se mueve a una direccion de memoria
		mov [hora],ax
		;y el contenido se imprime
		mov rax,1	;sys_write
		mov rdi,1	;std_out
		mov rsi,hora;primer parametro: Texto
		mov rdx,1	;segundo parametro: Tamano texto
		syscall
		;shift r9 en 4 bits a la derecha para movernos al siguiente nibble
		shr r9,4
		;Decrementar el contador almacenado en CL. Cuando se llega a cero, se termina
		;la ejecucion de la macro
		dec r8
		jnz loop3
%endmacro

%macro dar_vuelta4 0 ;no recibe parametros ya que solo es para darle
mov r10, r9					;vuelta al registro
mov r8, 0x8
loop_14:
	shl r9, 4
	mov r12, r10
	and r12, 0x0000000f
	shr r10, 4
	add r9, r12
	dec r8
	jnz loop_14
%endmacro
%macro imprimir_reg4 0 	;No recibe parametros
	;Para imprimir los 64 bits como caracteres ASCII se debe hacer un loop.
	;Los 64 bits almacenan 8 nibbles, osea que se debe repetir 8 veces.
	;Para hacer las repeticiones, usamos el registro R8
	mov r8,0x8
	loop4:
		mov r10,r9
		;lookup con XLAT
		and r10,0x0000000f
		mov rdx,r10
		lea ebx,[tabla]
		mov al,dl
		xlat
		;Cada nibble se mueve a una direccion de memoria
		mov [min],ax
		;y el contenido se imprime
		mov rax,1	;sys_write
		mov rdi,1	;std_out
		mov rsi,min;primer parametro: Texto
		mov rdx,1	;segundo parametro: Tamano texto
		syscall
		;shift r9 en 4 bits a la derecha para movernos al siguiente nibble
		shr r9,4
		;Decrementar el contador almacenado en CL. Cuando se llega a cero, se termina
		;la ejecucion de la macro
		dec r8
		jnz loop4
%endmacro

%macro dar_vuelta5 0 ;no recibe parametros ya que solo es para darle
mov r10, r9					;vuelta al registro
mov r8, 0x8
loop_15:
	shl r9, 4
	mov r12, r10
	and r12, 0x0000000f
	shr r10, 4
	add r9, r12
	dec r8
	jnz loop_15
%endmacro
%macro imprimir_reg5 0 	;No recibe parametros
	;Para imprimir los 64 bits como caracteres ASCII se debe hacer un loop.
	;Los 64 bits almacenan 8 nibbles, osea que se debe repetir 8 veces.
	;Para hacer las repeticiones, usamos el registro R8
	mov r8,0x8
	loop5:
		mov r10,r9
		;lookup con XLAT
		and r10,0x0000000f
		mov rdx,r10
		lea ebx,[tabla]
		mov al,dl
		xlat
		;Cada nibble se mueve a una direccion de memoria
		mov [seg],ax
		;y el contenido se imprime
		mov rax,1	;sys_write
		mov rdi,1	;std_out
		mov rsi,seg;primer parametro: Texto
		mov rdx,1	;segundo parametro: Tamano texto
		syscall
		;shift r9 en 4 bits a la derecha para movernos al siguiente nibble
		shr r9,4
		;Decrementar el contador almacenado en CL. Cuando se llega a cero, se termina
		;la ejecucion de la macro
		dec r8
		jnz loop5
%endmacro





; IMPRIMIR TEXTO
		%macro impr_texto 2 	;recibe 2 parametros
			mov rax,1	;sys_write
			mov rdi,1	;std_out
			mov rsi,%1	;primer parametro: Texto
			mov rdx,%2	;segundo parametro: Tamano texto
			syscall
		%endmacro
; GUARDAR TEXTO
		%macro guar_texto 2 	;recibe 2 parametros
		
			mov rbx,3	
			mov rax,4	
			mov rcx,%1	
			mov rdx,%2	
			int 0x80
			

		%endmacro


;------------------------- FIN DE MACRO --------------------------------





















section .data
	txt_wait: db 'Digite la cantidad de segundos a monitorear (Formato: CDU): '
	wait_len: equ $-txt_wait
	txt_tin: db 'Tiempo de monitoreo: ',
	tin_len: equ $-txt_tin
	cnst: db 0xa
	txt_error: db 'Error. Digite el numero de segundos en formato CDU (Centenas-Decenas-Unidades).',0xa
	err_len: equ $-txt_error
	txt_check: db 'DATOS',0xa
	chk_len: equ $-txt_check


archive db "./Proyect3.txt",0    ;archivo creado

sep_res: db '--------------------------------------',0xa
sep_res_tam: equ $-sep_res

tano: db 'ano:',0xa
tano_tam: equ $-tano

tmes: db 'mes:',0xa
tmes_tam: equ $-tmes

tdia: db 'dia:',0xa
tdia_tam: equ $-tdia

thora: db 'hora:',0xa
thora_tam: equ $-thora	

tmin: db 'minutos:',0xa
tmin_tam: equ $-tmin	

tseg: db 'segundos:',0xa
tseg_tam: equ $-tseg	

cons_esp: db ' ', 0xa
cons_tam_esp: equ $-cons_esp



cons_nueva_linea: db 0xa
;La tabla es necesaria para poder indexar los caracteres ASCII
tabla: db "0123456789ABCDEF",0




section .bss

		;Esta es una seccion de memoria de 4 bytes para guardar el valor del
		;registro que se desea imprimir
    mi_registro: resb 1
		un_ascii: resb 1



result_fd: resb 8

result1: resb 56
fecha: resb 56
ano: resb 1
mes: resb 1
dia: resb 56
hora: resb 56
min: resb 8
segu: resb 56
un_byte: resb 1
dia1: resb 8
ano1: resb 8
hora1: resb 8
min1: resb 8





 	idarchive resd 8                        ;identificador de archivo


	valor_max: resb 3	
	tiempo_espera:
		tv_sec: resq 1
		tv_nsec: resq 9
	temp: resb 3 				;Direccion temporal para convertir segundos CDU a segundos
section .text
	global _start	
	
_start:
	impr_texto txt_wait, wait_len		;Se imprime el encabezado
	
	;Captura teclas
	
	mov rax,0
	mov rdi,0
	mov rsi,valor_max	
	mov rdx,4;Se capturan 4 teclas
	syscall

	mov r8,[valor_max]					;Se asigna a los registros r8,r9 y r10 el valor digitado
	mov r9,[valor_max]
	mov r10,[valor_max]
	

	and r8, 0x0000FF						;Se aplica una mascara para obtener centenas
	and r9, 0x00FF00						;Se aplica una mascara para obtener decenas
	shr r9, 8								;Shift right para guardar las decenas sin ceros a la derecha
	and r10, 0xFF0000					;Se aplica una mascara para obtener unidades
	shr r10,16								;Shift right para guardar las unidades sin ceros a la derecha

	cmp r8,0x30							;Se compara cada digito ASCII para asegurarse de que 
	jl _error								;sean numeros. Si no cumple se salta a error
	cmp r8,0x39	
	jg _error
	cmp r9,0x30
	jl _error
	cmp r9,0x39	
	jg _error
	cmp r10,0x30
	jl _error
	cmp r10,0x39	
	jg _error

	
	cmp r8,0x30							;Se compara cada digito con cero, de modo que si todos
	jne _valid								;son cero, se salta a error.
	cmp r9,0x30
	jne _valid
	cmp r10,0x30
	
	je _error

	_valid:									;Inicia secuencia para datos validos
	
	sub r8,0x30							;Conversion ASCII a decimal
	sub r9,0x30
	sub r10,0x30

	mov eax,0x64							;Se toma el digito de centenas y se convierten a unidades
	mul r8									;multiplicando por 100
	mov [temp],eax
	mov r8,[temp]
	
	mov eax,0xa							;Se toma el digito de decenas y se convierten a unidades
	mul r9									;multiplicando por 10
	mov [temp],eax
	mov r9,[temp]

	add r10,r9								;Se suman las tres variables de unidades y se guardan en	
	add r10,r8								;temp
	mov [temp],r10
	
	impr_texto txt_tin,tin_len			;Se imprime el tiempo digitado por el usuario para 
	impr_texto valor_max,3				;corroborar
	impr_texto cnst,1
	
	;---------------------------------------------------------------------------------------------------
	;------------------CREACION DE ARCHIVO DE TEXTO----------------------

                       ;Crear el archivo txt
mov eax, 8
mov ebx, archive
mov ecx, 0x0777

int 0x80





	;---------------------------------------------------------------------------------------------------
	
	waitloop:								;Inicio del ciclo de espera

	xor r9,r9								;Se almacena cero en r9
	mov r8,1								;Se almacena uno en r8
	mov [tv_sec],r8						;Se establece un segundo de espera
	mov [tv_nsec],r9						;Se establecen cero nanosegundos de espera
	
	mov rax,35 												
	mov rdi,tiempo_espera
	xor rsi,rsi
	syscall									;Llamada al sistema para tiempo de espera
	

	;---------------------------------------------------------------------------------------------------
	;------------SECCION DE ESCRITURA EN ARCHIVO-----------------------



;Conseguir año
_ano:


mov rax,96; deja listo cual llamada de siste se va hacer
mov rdi,fecha; direcciona la posición en la que se va a guardar
syscall; se hace la llamada de sistema
mov r8,[fecha]; se obtiene el valor almacenado en dicha dirección, para su uso
mov rdx,0x0
mov rax,r8; se agrega el dividendo
mov r9,0x01E1853E; se agrega el divisor, en este caso corresponde al numero de segundos que hay en un año
div r9; se realiza la divison
mov [ano1],rax ; se almacena los número de años que han pasado desde la fecha mencionada, hasta la fecha actual
mov r8,0x7B2; se agrega el numero 1970
add r8,rax; se suma el numero de años que han pasado a 1970, para obtener el año actual

; se almacena el dato final en la variable ano
mov r9,r8
mov [ano],r9


impr_texto sep_res, sep_res_tam    ;Se imprime la separacion 
guar_texto sep_res, sep_res_tam         ;Se guarda en txt la seperacion para separar los resultados distintos


impr_texto tano,tano_tam   ;se imprime ano:
guar_texto tano,tano_tam    ;se guarda en txt



	dar_vuelta        ;da vuelta al reg
	
	imprimir_reg       ;imprime en pantalla



impr_texto cons_esp, cons_tam_esp    ;se hace un espacio


impr_texto sep_res, sep_res_tam      ;Se imprime la seperacion para separar los resultados
guar_texto sep_res, sep_res_tam      ;Se guarda en txt la seperacion para separar los resultados distintos







	;---------------------------------------------------------------------------------------------------
	;Se obtiene la fecha, la hora y el porcentaje
	;Se escriben en el archivo
	;---------------------------------------------------------------------------------------------------
	
				

	
	mov r10,[temp]						;Se carga el tiempo de espera
	dec r10								;Se disminuye el 1 el tiempo de espera
	mov [temp],r10						;Se guarda el nuevo tiempo de espera
	
	jnz waitloop							;Se salta al ciclo si el tiempo de espera no es cero

	_end:
 
	mov rax,60						
	 mov rdi,0
 	 syscall	

 

	_error:
	impr_texto txt_error,err_len		;Se imprime mensaje de error
	cmp r12,r12
	je _start
