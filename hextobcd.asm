%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro
section .data
m1 DB &quot;Enter the four digit hex input&quot;,10d,13d
l1 equ $-m1
m2 DB &quot;Equivalent bcd number is&quot;,10d,13d
l2 equ $-m2
section .bss
buf resb 6
digitcount resb 1
char_ans resb 4
num resb 6
section .text
global _start:
_start:
scall 1,1,m1,l1
call accept_proc
mov ax,bx
mov rbx,0Ah
back:
xor rdx,rdx
div rbx
push dx
inc byte[digitcount]
cmp rax,0H
jne back
print_bcd:
pop dx
add dl,30H
mov [char_ans],dl
scall 1,1,char_ans,1
dec byte[digitcount]
jnz print_bcd
mov rax,60
mov rdi,0
syscall

accept_proc:
scall 0,0,buf,5
xor bx,bx
xor ax,ax
mov rcx,4
mov rsi,buf
next_digit:
rol bx,04h
mov al,[rsi]
cmp al,39h
jbe L1
sub al,07h
L1: sub al,30h
add bx,ax
inc rsi
dec rcx
jnz next_digit
;loop next_digit
ret
