;coding:GBK
;��������Сд�ַ����������Сд�ַ�ת��Ϊ��д��ĸ����������ESC�����ַ�����ֹͣ
assume cs:code
code segment
start:  mov ah,1
        int 21h ;����1������

        cmp al,1bH
        je exit

        add al,32

        mov ah,2
        mov dl,al
        int 21h     ;����2,���

        cmp al,27
        jne start
    

exit:   mov ax,4c00h
        int 21h

code ends
end start