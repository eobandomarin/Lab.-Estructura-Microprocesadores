; MACROS

; IMPRIMIR TEXTO
		%macro impr_texto 2 	;recibe 2 parametros
			mov rax,1	;sys_write
			mov rdi,1	;std_out
			mov rsi,%1	;primer parametro: Texto
			mov rdx,%2	;segundo parametro: Tamano texto
			syscall
		%endmacro

section .data
	txt_wait: db 'Digite la cantidad de segundos a monitorear (Formato: CDU): '
	wait_len: equ $-txt_wait
	txt_tin: db 'Tiempo de monitoreo: ',
	tin_len: equ $-txt_tin
	cnst: db 0xa
	txt_error: db 'Error. Digite el numero de segundos en formato CDU (Centenas-Decenas-Unidades).',0xa
	err_len: equ $-txt_error
	txt_check: db 'CUENTA',0xa
	chk_len: equ $-txt_check
section .bss
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
	;---------------------------------------------------------------------------------------------------
	;Se obtiene la fecha, la hora y el porcentaje
	;Se escriben en el archivo
	;---------------------------------------------------------------------------------------------------
	
	
	impr_texto txt_check,chk_len		;PRUEBA ESCRITURA
	
	mov r10,[temp]						;Se carga el tiempo de espera
	dec r10								;Se disminuye el 1 el tiempo de espera
	mov [temp],r10						;Se guarda el nuevo tiempo de espera
	
	jnz waitloop							;Se salta al ciclo si el tiempo de espera no es cero

	_end:
 
	mov rax,60						
	 mov rdi,0
 	 syscall									;Llamada al sistema para finalizar programa

	_error:
	impr_texto txt_error,err_len		;Se imprime mensaje de error
	cmp r12,r12
	je _start								;Se salta de nuevo al inicio
	  


	