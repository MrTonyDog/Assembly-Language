;coding:gbk
;��buf��buf1,buf2��Ԫ�ֱ����һ���޷����ֽ�������,(0~255)
;������������������max��Ԫ,������Ļ����ʾ.
assume cs:code,ds:data
data segment
    buf  db     ?           ;   3,1,5
    buf1 db     ?           ;   max=0
    buf2 db     ?
    max  db    '0' 
    max1 db 'The max num is:    ','$'
    buf3 db 'Please input the num:    ','$'
data ends

code segment
start:  mov ax,data
        mov ds,ax
        mov cx,3
        mov si,0

        mov ah,9
        mov dx,offset buf3              ;Please input the num:    
        int 21h

input1: mov ah,1                        ;����������,������
        int 21h
        mov ds:byte ptr [si],al
        inc si
        mov ah,2
        mov dl,' '
        int 21h
        loop input1

        mov ah,2
        mov dl,0ah
        int 21h

        

        mov cx,3
        mov si,0
goback: mov bl,ds:byte ptr [si]
        cmp ds:byte ptr [max],bl
        jb handle           ;С������ת
tack:   inc si
        loop goback
        jmp over

handle: 
        mov ds:byte ptr [max],bl
        jmp tack

over:   mov ah,9
        mov dx,offset max1
        int 21h
        mov ah,2
        mov dl,ds:[max]
        int 21h

        mov ax,4c00h
        int 21h      
code ends
end start