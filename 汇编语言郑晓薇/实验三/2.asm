;coding:GBK
;��W��X��Y��Z��Ϊ8λ����������Ҫ����ɼ�����ʽW=X+Y-Z��
;2.������������ڵ���10����ʾ�Ľ����ȷ����ν��

;(�˳����Ƕ���λʮ���������д���)
; 12/10 = 1,         12 mod 10 = 2
;��                         ��    


assume cs:code,ds:data
data segment
    x db 7     ;7+8-3     
    y db 8
    z db 3
    w db ?      ;w=x+y-z
    k db 10
data ends
code segment
start:  mov ax,data
        mov ds,ax
        mov al,x    
        add al,y 
        sub al,z
        mov ds:[w],al

        mov al,ds:byte ptr [w]
        mov ah,00H
        div ds:byte ptr [k]         ;ah��������al������

        mov bl,al
        mov bh,ah
        mov ah,2
        mov dl,bl
        add dl,30h
        int 21h             ;ִ�����al��ֵ����dl��ֵ


        mov ah,2 
        mov dl,bh
        add dl,30h   
        int 21h             ;ִ�����al��ֵ����dl��ֵ

        mov ax,4c00h
        int 21h

code ends
end start