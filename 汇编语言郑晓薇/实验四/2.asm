;coding:GBK
;3.��Ϊ�Ӽ�������X��Y��Z��ֵ���ֱ�Ϊ1,4,3
;�����ʽ:  3+2-1=4

assume cs:code,ds:data,ss:stack
data segment
    x db ?  ;3
    y db ?  ;2
    z db ?  ;1
    w db ?  
data ends

stack segment
    dw 3 dup (0)
stack ends

code segment
start:  mov ax,data
        mov ds,ax
        mov cx,3
        mov si,0
        mov ax,stack
        mov ss,ax
        mov sp,0006h

   
       mov ax,'='   ;������ȫ��ѹջ
       push ax
       mov ax,'-'
       push ax
       mov ax,'+'
       push ax

    s:  mov ah,1    ;�Ӽ���������һ���ַ��������ַ���ASCII������al��    
        int 21h
        mov ds:byte ptr [si],al

        mov ah,2    
        pop dx      ;���ŵ�ջ
        int 21h

        inc si
        loop s
        
        mov al,00h              ;����
        mov al,ds:byte ptr [x]
        add al,ds:byte ptr [y]
        sub al,ds:byte ptr [z]
        mov ds:byte ptr [w],al

        mov ah,2            ;���w�Ľ��
        mov dl,ds:byte ptr [w]
        int 21h             ;ִ�����al��ֵ����dl��ֵ


        mov ax,4c00h
        int 21h

code ends
end start
