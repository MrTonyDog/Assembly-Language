;coding:GBK
;Ҫ�󣺣�1����9�Ź�����ʾһ���ַ����硱INPUT  YOUR NAME:�� 
;��2���ڴ���β���������Ӣ�����֣�����3���ַ������س�����
;��3������һ�У�������ʾ����������֣�
;��4�����ֺ��棬������ʾ����(y/n)?��
;��5�� ����Ϊ��ĸ��y����������������ĸ��n���ص���1���������롣

assume cs:code,ds:data
data segment
   x db 'INPUT  YOUR NAME:','$'
   y db 10,?,4 dup (0ah,'$')
data ends
code segment
start:      mov ax,data
            mov ds,ax
            mov dx,0
            mov ah,9    ;����9�����һ���ַ���
            int 21h


            mov ah,10   ;����10������һ���ַ���
            mov dx,offset y
            int 21h

            mov dx,offset y+2       ;mov dx,0014
            mov ah,9    ;����9�����һ���ַ���
            int 21h

            ;mov ah,2
           ; mov dl,0ah
            ;int 21h   

            ;mov ah,2
            ;mov dl,20h
            ;int 21h

            ;mov ah,2
            ;mov dl,'$'
           ; int 21h   
      

            mov ax,4c00h
            int 21h
code ends   
end start