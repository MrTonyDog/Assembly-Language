;coding:gbk
;ʵ���壬��֧������Ƶĵ����⣺
;��Ŀ:
;���ڴ�����buf��Ԫ��ʼ�����������������10��
;ѧ���ķ������Ա��Ƴ���ͳ������90~100�֣�80~89�֣�60~79��
;��60�������߸��ж����ˣ����ѽ���ֱ���
;��S9,S8,S7��S6�У�����ʾ��������

assume cs:code,ds:data
data segment
    buf db 14,?,12 dup ('$')
    buf1 db 'Please input the num','$'
data ends
code segment
start:      mov ax,data
            mov ds,ax

            mov ah,9
            mov dx,offset buf1
            int 21h
            call CR1

            mov ah,10   ;����10������your name
            mov dx,offset buf+2
            int 21h
            call CR
            
            call CR1
            
            mov ax,4c00h
            int 21h

      CR:   mov bx,offset buf                     ;�������ַ����еĻس�ɾ��
            inc bx
            add bl,ds:byte ptr [bx]
            inc bx
            mov ds:byte ptr [bx],'$'
            ret

    CR1:    mov ah,2
            mov dl,0ah
            int 21h
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