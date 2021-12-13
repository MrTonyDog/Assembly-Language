;����һ�����������ꡢ�¡���
;1��	�����Ƿ������ꣿ							[#]
;2��	��������һ��ĵڼ��죿
;3��	������һ��ÿ�����һ���Ǳ����еĵڼ��죿
;4��	�����������ļ�test1.txt�������С�

;ÿ����31����� 1�¡�3�¡�5�¡�7�¡�8�¡�10�¡�12�£�һ�����߸��£�
;ÿ��30����� 4�¡�6�¡�9�¡�11�¹��ĸ���
;2����ƽ�£���ʮ���죩���������£���ʮ���죩

;ƽ��:	1��:31	2��:31+day	3��:31+28+day	4��:31+28+30+day	5��:31+28+30+30+day
;		6��:31+28+30+30+31+day	7��:31+28+30+30+31+30+day	8��:31+28+30+30+31+30+31+day
;		9��:31+28+30+30+31+30+31+31+day		10��:31+28+30+30+31+30+31+31+30+day
;coding: gbk
assume cs:code,ds:data,ss:stack
Notice0  MACRO x1
	mov ah,9
	mov dx,offset x1
	int 21h
ENDM
data segment
    Divisor1 dw 4
	Divisor2 dw 100
	Divisor3 dw 400
	Month31  db 31	;ÿ����31����� 1�¡�3�¡�5�¡�7�¡�8�¡�10�¡�12�£�һ�����߸���
	Month30	 db 30	;ÿ��30����� 4�¡�6�¡�9�¡�11�¹��ĸ���
	Month28  db 28	;ƽ��2�¶�ʮ����
	Month29  db 29	;����2�¶�ʮ����

	leap     dw 0
	leapflag db 0		;leapflagΪ1ʱ����������������
	userMonth db 0      ;�û�������·�
	userDay   db 0     	;�û����������
	totalDay  dw 0 		;�����ܵ�����

	buf1     db 0ah,0dh,'The year is Leap year',0ah,0dh,'$'
	buf2     db 0ah,0dh,'The year is Common year',0ah,0dh,'$'
	
	notice1  db 0ah,0dh,'Please input the year',0ah,0dh,'$'
	notice2  db 0ah,0dh,'Please input the month',0ah,0dh,'$'
	notice3  db 0ah,0dh,'---------------------------------------------------',0ah,0dh,'$'   ;����
	notice4  db 0ah,0dh,'Please input the day',0ah,0dh,'$'

	errorbuf1 db 0ah,0dh,'Please input the correct num!',0ah,0dh,'$'
data ends

stack segment
	dw 20 dup (?)
stack ends	

code segment
start:  mov ax,data
        mov ds,ax
		mov ax,stack
		mov ss,ax
		mov sp,14h
		Notice0 notice1
        call Control1	;�������
        call Judge		;�ж��Ƿ�������,��Ҫִ����Control1���ax
		call CalculationDate	;�����������һ��ĵڼ��죿
        
over1:  mov ax,4c00h
        int 21h

CalculationDate proc far	;�����������һ��ĵڼ��죿
start1: 
		Notice0 notice2 ;Please input the month
		mov ax,0
		mov ah,1
		int 21h
		cmp al,'0'
		jb error1
		cmp al,'9'
		ja error1
		sub al,30h		;003b
		mov ds:byte ptr [userMonth],al		;�����û�������·�
start2: Notice0 notice3	;---------------------------------	
		Notice0 notice4	;Please input the day
		mov ax,0
		call Control1
		cmp ax,31
		ja  error2
		sub al,30h
		mov ds:byte ptr [userDay],al		;�����û����������
		;�����������һ��ĵڼ��죿
		mov ax,0
		mov cx,0
		mov cl,ds:byte ptr [userMonth]		;���·�-1��Ϊѭ������
		sub cl,1


loop1:	;call CaDay
		loop loop1
		mov ax,0
		mov al,ds:byte ptr [userDay]
		add ds:word ptr [totalDay],ax	;+day

		mov dx,0
		mov ax,ds:word ptr [totalDay]
		call stackdiv16
		
		jmp over3
	
error1:Notice0 errorbuf1	;Please input the correct num!
	   jmp start1
error2:Notice0 errorbuf1	;Please input the correct num!
	   jmp start2

over3:	ret
CalculationDate endp

CaDay	proc far
		.if cl==11
			add ds:word ptr [totalDay],30
		.endif
		.if cl==10
			add ds:word ptr [totalDay],31
		.endif
		.if cl==9
			add ds:word ptr [totalDay],30
		.endif
		.if cl==8
			add ds:word ptr [totalDay],31
		.endif
		.if cl==7
			add ds:word ptr [totalDay],31
		.endif
		.if cl==6
			add ds:word ptr [totalDay],30
		.endif
		.if cl==5
			add ds:word ptr [totalDay],31
		.endif
		.if cl==4
			add ds:word ptr [totalDay],30
		.endif
		.if cl==3
			add ds:word ptr [totalDay],31
		.endif
		.if cl==2						;���⣬�������ж��Ƿ�������
			.if ds:byte ptr [leapflag] == 1	;���Ϊ����
				add ds:word ptr [totalDay],29
			.endif
			.if ds:byte ptr [leapflag] == 0	;���Ϊƽ��
				add ds:word ptr [totalDay],28
			.endif
		.endif
		.if cl==1
			add ds:word ptr [totalDay],31
		.endif

		ret
CaDay	endp

stackdiv16 proc far
              push bx
              push dx
              push si
              mov si,0
              
cricle1:      mov bx,10
              div bx

              cmp ax,0
              jbe  next1     ;�̱�0С���˳�����������ȫ���������
              
              push dx
              inc si
              mov dx,0

              jmp cricle1

next1:        push dx
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
             
next3:        
              pop si     
              pop dx       
              pop bx
              ret


stackdiv16 endp

Judge proc far
    mov dx,0
	mov ds:word ptr [leap],ax
    div ds:word ptr [Divisor3]	;����400
    cmp dx,0					;�����0����,��������
	jz leapyear0
	
	mov dx,0
	mov ax,ds:word ptr [leap]
	div ds:word ptr [Divisor1]
	cmp dx,0
	jz judge1				;����ܱ�4����,������ж�
	jmp judge2

judge1: mov dx,0
		mov ax,ds:word ptr [leap]
		div ds:word ptr [Divisor2]
		cmp dx,0
		jnz leapyear0			;������ܱ�100��������������
judge2:					
		Notice0 buf2			;���The year is Common year
		Notice0 notice3
		jmp over2


leapyear0: 
		   Notice0 buf1	;���The year is Leap year
		   Notice0 notice3
		   mov ax,0
		   mov al,ds:byte ptr [leapflag]
		   mov al,1
    
over2:	   ret
Judge endp

Control1 proc far			
		
		push bx
		push cx
		push dx
		xor bx, bx  ;bl������	�������λ��ֵ��ͬ��ͬΪ 0 ��ͬΪ 1��������λ���� 0��������λ���� 1��
		xor cx, cx  ;��cx����
                xor dx, dx									   ;CXΪ������־��0Ϊ������1Ϊ��
		mov ah, 1	
		int 21h				
		cmp al, '+'
		jz symbol1
		cmp al, '-'
		jnz symbol2	
		mov cx, -1
symbol1: 						;����:�����������֣�ֱ�����벻�����־ͽ���
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
		neg bx
exit2:
		mov ax, bx
		pop dx
		pop cx
		pop bx
		ret

        ret
		
change proc far         ;x * 10
	shl bl, 1	
	mov dl, bl	
	shl bl, 1	
	shl bl, 1       ;��bl�е�������������,ʹbl==8
	add bx, dx
	add bx, ax      
        ret
change endp

Control1 endp

code ends
end start