;���Ƴ������s=1+2+3+4+...+n ֱ���ʹ���500Ϊֹ,
;�����������Ļ����ʾ����(n��ֵ�����պ͵�ֵ)

assume cs:code,ds:data,ss:stack

data segment
    buf1 db 'The n is (d):','$'
    buf2 db 'The sum is (d):','$'
    n dw ?
    sum dw ?
data ends

stack segment
    dw 8 dup (?)
stack ends

code segment
start:      mov ax,data
            mov ds,ax

            mov ax,stack
            mov ss,ax
            mov sp,10h

            mov ds:word ptr [sum],0
            mov ds:word ptr [n],1

goback:     cmp ds:word ptr [sum],500
            ja over1
            mov bx,ds:word ptr [n]
            add ds:word ptr [sum],bx
            add ds:word ptr [n],1
            jmp goback


    over1:  mov ah,9
            mov dx,offset buf1      ;The n is :
            int 21h

            mov ax,ds:word ptr [n]
            mov dx,0
            call stackdiv16
            call CR2

            mov ah,9
            mov dx,offset buf2       ;The sum is :
            int 21h

            mov ax,ds:word ptr [sum]
            mov dx,0
            call stackdiv16
            call CR2

    over0:  mov ax,4c00h
            int 21h

            ;������Ĭ�Ϸ���dx,ax��
            ;123
stackdiv16:   push si
              mov si,0

cricle:       cmp ax,99     ;�������2λ����������
              jae cricle2

cricle1:      mov bx,10
              div bx

              cmp dx,0
              jbe  next1     ;������0С���˳�����������ȫ���������
              
              push dx
              inc si
              mov dx,0

              jmp cricle1

cricle2:      mov bx,10
              div bx
              push dx
              mov dx,0
              div bx
              push dx
              push ax
              add si,3
              jmp next2

next1:        push ax
              inc si
next2:        cmp si,0
              jbe next3         ;���������С��0�������

              pop bx
              dec si
              mov ah,2
              mov dl,bl
              add dl,30h
              int 21h

              jmp next2

 
next3:        call CR2          ;�س��ͻ���
              pop si            
              ret
              
    CR2:    mov ah,2
            mov dl,0ah
            int 21h   
            mov ah,2
            mov dl,0dh
            int 21h
            ret
code ends
end start