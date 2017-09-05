;-------------------------------------------------------------------------
;-------------------MEMORIA CACHE------------------------
;-------------------------------------------------------------------------

;__________________________________________
;                                      MACROS
;__________________________________________

; IMPRIMIR TEXTO
		%macro impr_texto 2 	;recibe 2 parametros
			mov rax,1	;sys_write
			mov rdi,1	;std_out
			mov rsi,%1	;primer parametro: Texto
			mov rdx,%2	;segundo parametro: Tamano texto
			syscall
		%endmacro

; IMPRIMIR HEXA
		%macro impr_hexa 1 	;recibe 2 parametros
			mov rdx,%1		
			lea ebx,[tabla]				
			mov al,dl
			xlat
			mov [byte_uno],ax
			impr_texto byte_uno,1
		%endmacro
;__________________DATOS____________________

section .data
	cachetxt: db 'Memoria Cache: ',0xa ;Texto cache
	lencachetxt: equ $-cachetxt ;Tamano texto cache
	
	cnst_esp: db 0xa
	
	dcache: db 'D'
	dospuntos: db ': '
	
	tabla: db "0123456789ABCDEF",0

;_______________STRUCTS______________________

section .bss
	reg_copia: resb 8							
	byte_uno: resb 1

;_________________TEXT________________________

section .text
	global _start

_start:
;-------Obtener datos CPUID------
	impr_texto cachetxt, lencachetxt 		;Se imprime el texto de cache
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
		impr_texto dcache,1					;Se imprime D
		impr_hexa r10						;Se imprime numero de dato
		impr_texto dospuntos,2				;Se imprimen dos puntos
		
		;--Variables y mascaras--
		mov r12,r9							;Se almacena en r12 los datos de cache
		mov r13,r9							;Se almacena en r13 los datos de cache
		shr r12,4								;Shift Right a r12 para seccionar en bloques de dos bytes
		and r12,0x0F							;Mascara para r12
		and r13,0x0F							;Mascara para r13
		
		;------Impresion datos------
		impr_hexa r12						;Se imprime el primer byte
		impr_hexa r13						;Se imprime el segundo byte
		impr_texto cnst_esp,1				;Se imprime un espacio para el siguiente ciclo

		;--Datos ciclo siguiente---	
		add r10,1								;Se suma 1 al contador de dato	
		shr r9,8								;Shift Right de 2 bytes para preparar el siguiente bloque
		dec r8									;Se resta 1 al contador de repeticiones restantes
	jnz loopcache								;Salto al ciclo

;---------Finalizar programa---------
	mov rax,60
	mov rdi,0
	syscall
;---------------------Fin------------------------

