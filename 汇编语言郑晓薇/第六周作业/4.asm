;coding:GBK

;[ֻ����ʾ��λ��]
;5.�ڴ˻����ϣ��ѳ����Ϊ����ı��ʽ��д�����룺   
;W=((X+Y)*2-Z)/2   ;X,Y,Z,W��Ϊ8λ��������ֵ

assume cs:code,ds:data,ss:stack
data segment
    x db ?  ;3
    y db ?  ;2
    z db ?  ;1
    w db ?  
data ends

stack segment
    dw 13 dup (0)
stack ends

code segment
start:  mov ax,data
        mov ds,ax
        mov cx,4
        mov si,0
        mov ax,stack
        mov ss,ax
        mov sp,001Ah


       mov ax,'='   ;������ȫ��ѹջ
       push ax   
       mov ax,'2'   
       push ax
       mov ax,'/'
       push ax
       mov ax,')'
       push ax
       mov ax,'-'
       push ax
       mov ax,'2'       
       push ax
       mov ax,'*'
       push ax
       mov ax,')'
       push ax
       mov ax,'+'
       push ax
       mov ax,'('
       push ax
       mov ax,'('
       push ax
       mov ax,'='
       push ax
       mov ax,'w'
       push ax
      
    s: mov ah,2    ;���ŵ�ջ
       pop dx      
       int 21h      
       loop s      ;w=((

       mov ah,1    ;�Ӽ���������һ���ַ��������ַ���ASCII������al��    
       int 21h      ;x
       mov ds:byte ptr [x],al

       mov ah,2    ;���ŵ�ջ
       pop dx      
       int 21h      ;+

       mov ah,1    ;�Ӽ���������һ���ַ��������ַ���ASCII������al��    
       int 21h      ;y
       mov ds:byte ptr [y],al

       mov cx,4
    s1:mov ah,2    ;���ŵ�ջ
       pop dx      
       int 21h      ;) *2-
      loop s1


       mov ah,1    ;�Ӽ���������һ���ַ��������ַ���ASCII������al��    
       int 21h      ;z
       mov ds:byte ptr [z],al


       mov cx,4
    s2:mov ah,2    ;���ŵ�ջ
       pop dx      
       int 21h      ;)/2=
        loop s2
                   
        
        mov ax,0000h              ;����
        mov al,ds:byte ptr [x]  ;x+y=w
        sub al,30h
        add al,ds:byte ptr [y]  ;x+y=w
        sub al,30h

        mov bl,02h
        mul bl      ;w*2���������ax��
        ;mov ds:byte ptr [w],al
        mov bl,ds:byte ptr [z]
        sub bl,30h
        sub al,bl  ;w-z
        mov dl,02h
        div dl

        mov ds:byte ptr [w],al

        mov ah,2            ;���w�Ľ��
        mov dl,ds:byte ptr [w]
        add dl,30h
        int 21h             ;ִ�����al��ֵ����dl��ֵ


        mov ax,4c00h
        int 21h

code ends
end start
