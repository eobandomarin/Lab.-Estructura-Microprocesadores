%macro escribe 2                               ;MARCO
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
int 0x80
%endmacro

segment .data
msg2 db "TEXTO GUARDADO",0xA                  ;mensaje de confirmacion
len2 equ $-msg2

archive db "./Prueba.txt",0    ;archivo creado
text db "dddddddddddddddddddd     fffffffffffffffffffff    mmmmmmmmmmmmmmmmmmmmmmmmmm",0
tamanotext equ $ - text

segment .bss


idarchive resd 1                          ;identificador de archivo


segment .text


global _start

_start:
 
                       ;Crear el archivo txt
mov eax, 8
mov ebx, archive
mov ecx, 0x0700

int 0x80

test eax, eax                 ;verificar si se logro crear 
jz salir
mov dword[idarchive], eax

escribe msg2, len2

mov ecx, text


mov eax, 4                      ;escribir en el archivo 
mov ebx, [idarchive]
mov ecx, text
mov edx, tamanotext                     ;numero de digitos 
int 0x80


mov eax, 6

salir:
 mov eax, 1
 xor ebx, ebx
 int 0x80
