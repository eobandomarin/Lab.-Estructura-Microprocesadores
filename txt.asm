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

archive db "/home/rob/Desktop/Prueba.txt",0    ;archivo creado
text db "hbcilbckeufcbkewucbwqeukcbwqekucbwqeicfwqeukyf64r3r488r2r82fy38348734f83834f3i8f87387383",0

segment .bss


idarchive resd 1                          ;identificador de archivo


segment .text


global _start

_start:
                        ;crear archivo
mov eax, 8
mov ebx, archive
mov ecx, 2
mov edx, 7777h
int 0x80

test eax, eax                 ;verificar si se logro crear 
jz salir
mov dword[idarchive], eax

escribe msg2, len2

mov ecx, text


mov eax, 4                      ;escribir en el archivo 
mov ebx, [idarchive]
mov ecx, text
mov edx, 100                     ;numero de digitos 
int 0x80




salir:
 mov eax, 1
 xor ebx, ebx
 int 0x80
