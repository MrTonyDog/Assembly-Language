;��̬�Ӽ�������20����λ�޷�����,�ҳ�����
;���������ʾ.

assume cs:code,ds:data,ss:stack
stack segment
    dw 10 dup (?)
stack ends

data segment
    buf1 db 'Please input the num!','$'
    number1 db 5 dup (?)
    max db ?
data ends

code segment
start:      mov ax,data
            mov ds,ax
            mov ax,stack
            mov ss,ax
            mov sp,14H  
            mov si,0
            mov cx,5 

            mov ah,9
            mov dx,offset buf1
            int 21h
            call CR2

continue1:  call control1                           ;����20����λ��
            mov ds:byte ptr [number1+si],al
            call CR2
            inc si
            loop continue1

            mov cx,5
            mov si,0
continue2:  mov al,ds:byte ptr [number1+si]         ;�����ֵ
            cmp al,ds:byte ptr [max]
            ja TheMax
continue3:  inc si
            loop continue2 

            mov dx,0
            mov ah,0
            mov bx,0
            mov al,ds:byte ptr [max]

            call stackdiv16

            
over1:      mov ax,4c00h
            int 21h

TheMax:     mov ds:byte ptr [max],al
            jmp continue3

control1:			
		push bx
		push cx
		push dx
		xor bl, bl  ;bl������	�������λ��ֵ��ͬ��ͬΪ 0 ��ͬΪ 1��������λ���� 0��������λ���� 1��
		xor cx, cx  ;��cx����									   ;CXΪ������־��0Ϊ������1Ϊ��
		mov ah, 1	
		int 21h				
		cmp al, '+'
		jz symbol1
		cmp al, '-'
		jnz symbol2	
		mov cx, -1
symbol1: 						;����:�����������֣�ֱ������س��ͽ���
		mov ah,  1
		int 21h
symbol2:    					;-��:
		cmp al, '0'				
		jb exit1		;���������ַ��в������ֵ�ascii��ֵ
		cmp al, '9'		
		ja exit1		;���������ַ��в������ֵ�ascii��ֵ
		
		sub al, 30h	;�����Ϊ������
		xor ah, ah	;��ah����
        call change
		jmp symbol1
exit1:
		cmp cx, 0
		jz exit2
		neg bl
exit2:
		mov al, bl
		pop dx
		pop cx
		pop bx
		ret

        ret

change:	shl bl, 1	
		mov dl, bl	;��0��dl
		shl bl, 1	;��bl�е���������
		shl bl, 1
		add bl, dl
		add bl, al
        ret




stackdiv16:   push si
              mov si,0

cricle:       cmp ax,99         ;�������2λ����������
              ja cricle2
              cmp ax,90         ;(�������)��ѹdx,��ѹax,���ջ
              jz    next4
              cmp ax,80
              jz    next4            
              cmp ax,70
              jz    next4
              cmp ax,60
              jz    next4
              cmp ax,50
              jz    next4
              cmp ax,40
              jz    next4
              cmp ax,30
              jz    next4
              cmp ax,20
              jz    next4
              cmp ax,10
              jz    next4             
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

next1:       
              push ax
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

next4:        mov bx,10
              div bx
              push dx
              push ax
              pop bx
              mov ah,2
              mov dl,bl
              add dl,30h
              int 21h
              pop bx
              mov ah,2
              mov dl,bl
              add dl,30h
              int 21h
              jmp next3              
 
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