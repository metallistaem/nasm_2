%macro _Push_all_reg 0
	PUSH eax
	PUSH ecx
	PUSH edx
	PUSH ebx
	PUSH ebp
	PUSH esi
	PUSH edi
%endmacro

%macro _Pop_all_reg 0
	POP edi
	POP esi
	POP ebp
	POP ebx
	POP edx
	POP ecx
	POP eax
%endmacro

section .data
    number db 5 
    mass db 1, 4, 6, 9, 0 
    len dd $ - mass 

section .text: 
    global _start 

procedure:
_Push_all_reg
	pushf
loop_start: 
    cmp [esi], bl 
    jg change 
    jmp point 
change: 
    mov [esi], bl 
point: 
    inc esi 
    loop loop_start
    popf 
	_Pop_all_reg
    ret 

_start: 
    mov esi, mass 
    mov ecx, [len] 
    mov bl, [number] 
    call procedure

    mov esi, mass 
    mov ecx, [len]
l1_:
    add [esi], byte 0x30
    inc esi
    loop l1_
    
    mov eax, 4 
    mov ebx, 1 
    mov ecx, mass 
    mov edx, [len] 
    int 0x80 

    mov eax, 1 
    mov ebx, 0 
    int 0x80