;coding:GBK
;Ҫ�󣺣�1����9�Ź�����ʾһ���ַ����硱INPUT  YOUR NAME:�� 
;��2���ڴ���β���������Ӣ�����֣�����3���ַ������س�����
;��3������һ�У�������ʾ����������֣�
;��4�����ֺ��棬������ʾ����(y/n)?��
;��5�� ����Ϊ��ĸ��y����������������ĸ��n���ص���1���������롣

assume cs:code,ds:data
data segment                     ;0a:���� , 0d:�س�,�ص���һ�еĶ�ͷ
   x db 'INPUT  YOUR NAME:','$'
   y db 10,?,8 dup ('$')         ;ֻ������6���ַ�,��ΪҪ��ȥ0dh��$(�ڴ�����ʾΪ: 0dh '$') 8-2 = 6
   z db '?(y/n)','$'
data ends
code segment
start:      mov ax,data
            mov ds,ax
            
         s0:mov ah,9    ;����9�����һ���ַ���:INPUT  YOUR NAME:
            mov dx,0 
            int 21h

            mov bx,0

            mov ah,10   ;����10������your name
            mov dx,offset y
            int 21h

            call CR



            mov ah,2
            mov dl,0ah
            int 21h   

            mov ah,2
            mov dl,0dh
            int 21h

            mov ah,9    ;����9�����your name
            mov dx,offset y+2       
            int 21h

            call CR

            mov ah,9    ;����9�����һ���ַ���:?(y/n)
            mov dx,offset z       
            int 21h

            mov ah,1
            int 21h

            cmp al,79h
            call CR1

            jnz s0
      
            mov ax,4c00h
            int 21h

      CR:   mov bx,offset y                     ;�������ַ����еĻس�ɾ��
            inc bx
            add bl,ds:byte ptr [bx]
            inc bx
            mov ds:[bx],'$'
            ret

      CR1:  mov ah,2                            ;����
            mov dl,0ah
            int 21h
            ret

code ends   
end start