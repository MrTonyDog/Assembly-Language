;��д�������溯��ֵ�ĳ���:
;X��ֵ�� -128 ~ 127֮��
;   1   x>0ʱ
;y= 0   x=0ʱ                   ;>=0Ϊ�ֽ磬
;  -1   x<0ʱ

;����������Ϊx
;�������y
;�ҽ�Ϊ�ֽڱ���.

assume cs:code,ds:data
data segment
    x db -11
    y db ?
data ends

code segment
start:  mov ax,data
        mov ds,ax
        cmp ds:[x],0
        jns s1              ;���ڵ���

    s2:           ;С��0(��)
        mov ah,2 
        mov dl,'<'
        int 21h
        jmp endline

    s1: 
        cmp ds:[x],0        ;���ڵ���0
        jz s3               ;�������0������ת
        mov ah,2            
        mov dl,'>'
        int 21h
        jmp endline

    s3: 
        mov ah,2        ;����0�����0
        mov dl,'0'
        int 21h
        jmp endline

    endline: mov ax,4c00h
             int 21h

code ends
end start
