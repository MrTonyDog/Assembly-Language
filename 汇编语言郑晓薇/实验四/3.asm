;coding:GBK

;4.�����ʽ:
;1
;4
;3
;2

assume cs:code,ds:data;,ss:stack
data segment
    x db ?  ;1
    y db ?  ;4
    z db ?  ;3
    w db ?  ;2
data ends

code segment
start:  mov ax,data
        mov ds,ax
        mov cx,3
        mov si,0

    s:  mov ah,1    ;�Ӽ���������һ���ַ��������ַ���ASCII������al��    
        int 21h
        mov ds:byte ptr [si],al

        
        mov ah,2
        mov dl,0aH
        int 21h

        mov ah,2
        mov dl,0dh
        int 21h

        inc si
        loop s

        mov si,0
        mov al,ds:[x]
        add al,ds:[y]
        sub al,ds:[z]
        mov ds:byte ptr [w],al

        mov ah,2
        mov dl,ds:byte ptr [w]
        int 21h             ;ִ�����al��ֵ����dl��ֵ

        mov ax,4c00h
        int 21h

code ends
end start
