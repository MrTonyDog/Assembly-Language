;coding:gbk
;ʵ���壬��֧������Ƶĵ����⣺
;��Ŀ:
;���ڴ�����buf��Ԫ��ʼ�����������������10��
;ѧ���ķ������Ա��Ƴ���ͳ������90~100�֣�80~89�֣�60~79��
;��60�������߸��ж����ˣ����ѽ���ֱ���
;��S9,S8,S7��S6�У�����ʾ��������

;90~100�֣�80~89�֣�60~79��,60������.

assume cs:code,ds:data,ss:stack
data segment
   x db 'INPUT  YOUR NAME:','$'
   y db 39,91,92,80,81,82,60,61,62,50         ;ֻ������6���ַ�,��ΪҪ��ȥ0dh��$(�ڴ�����ʾΪ: 0dh '$') 8-2 = 6
   buf1 db 'The number is too big','$'
   buf2 db 's9 hava :','$'
   buf3 db 's8 hava :','$'
   buf4 db 's7 hava :','$'
   buf5 db 's6 hava :','$'
   s9 db ?
   s8 db ?
   s7 db ?
   s6 db ?
   num db ?
data ends

stack segment
   dw 7 dup ('/')         ;bug
stack ends

code segment
start:      mov ax,data
            mov ds,ax

            mov ax,stack
            mov ss,ax   
            mov sp,0eh  ;bug

            mov cx,10
            mov bx,0
            mov bx,offset y
    main:   call control1
            mov ds:byte ptr [bx],al

            cmp ds:byte ptr [bx],100     ;������������̫��
            ja over2

            cmp ds:byte ptr [bx],60      ;���С��60��
            jb set1

            cmp ds:byte ptr [bx],90      ;������ڵ���90��
            jae set2

            cmp ds:byte ptr [bx],80      ;������ڵ���80��
            jae set3    

            cmp ds:byte ptr [bx],60      ;������ڵ���60��
            jae set4
            
    continue:
            inc bx        
            loop main
            jmp over1

    set1:   ;mov ah,2
            ;mov dl,'3'
            ;int 21h
            
            add ds:byte ptr [s6],1
            call output
            mov ah,9
            mov dx,offset buf5  
            int 21h

            mov ah,2
            mov dl,ds:byte ptr [s6]
            add dl,30h
            int 21h

            call CR2
            jmp continue

    set2:   ;mov ah,2
            ;mov dl,'9'
            ;int 21h

            add ds:byte ptr [s9],1  
            call output
            mov ah,9
            mov dx,offset buf2  
            int 21h

            mov ah,2
            mov dl,ds:byte ptr [s9]
            add dl,30h
            int 21h

            call CR2
            jmp continue   

    set3:   ;mov ah,2
            ;mov dl,'8'
            ;int 21h
            

            add ds:byte ptr [s8],1
            call output
            mov ah,9
            mov dx,offset buf3  
            int 21h

            mov ah,2
            mov dl,ds:byte ptr [s8]
            add dl,30h
            int 21h

            call CR2
            jmp continue

    set4:   ;mov ah,2
            ;mov dl,'7'
            ;int 21h

            add ds:byte ptr [s7],1
            call output
            mov ah,9
            mov dx,offset buf4  
            int 21h

            mov ah,2
            mov dl,ds:byte ptr [s7]
            add dl,30h
            int 21h

            call CR2
            jmp continue

    over2:  call CR2
            mov ah,9
            mov dx,offset buf1
            int 21h
            ;call CR2
            jmp continue

    over1:  mov ax,4c00h
            int 21h


    CR2:    mov ah,2
            mov dl,0ah
            int 21h   
            mov ah,2
            mov dl,0dh
            int 21h
            ret

output:     mov ah,2
            mov dl,0dh
            int 21h
            ret


            
control1:	push bx
		push cx
		push dx			

		xor bl, bl  
		xor cx, cx  ;��cx����	;CXΪ������־��0Ϊ������1Ϊ��
		mov ah, 1	
		int 21h				
		cmp al, '+'
		jz symbol1
		cmp al, '-'
		jnz symbol2	
		mov cx, -1
symbol1: ;����:�����������֣�ֱ������س��ͽ���
                
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
                call CR2
		jz exit2
		neg bl
exit2:
		mov al, bl
  		pop dx
		pop cx
		pop bx               
		ret
               
                ret

change:	        shl bl, 1	
		mov dl, bl	;��0��dl
		shl bl, 1	;��bl�е���������
		shl bl, 1
		add bl, dl
		add bl, al
                ret

code ends
end start