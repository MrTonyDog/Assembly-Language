;��̬���������������������λ��-��������
DATAS SEGMENT
   buf dw 100 dup(?)       ;Ԥ��100������Ԫ��
   max dw ?                ;���ֵ
   COUNT DW ?              ;����Ԫ�ظ���
   CHUSHU DW 10            ;��������ȡ�����õ�10
   error db 'input error',13,10,'$'
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
      MOV   AX,DATAS
      MOV   DS,AX
      
      mov   si,0
      mov   di,0
      
      MOV   BX, 0         ;ÿ���Ӽ��̽��յĶ�λ�����շ�BX�������ڴ浥ԪBUF
lp1:  MOV   AH, 1
      INT   21H
      cmp   al,32          ;���ո�������һ������
      jz    lp2
      push ax              ;����Ax�������ж��ǲ��ǻس�
      cmp   al,13
      jz    lp2            ;�س���������Ҫ�����ۼƸ���������
      SUB   AL, 30H         
      
      JL    error1         ; <0 ���� ��������
      CMP   AL, 9
      JG    error1         ; >9 ���� ��������
      CBW
      XCHG  AX, BX         ;33-37��ʵ�ְѴӼ�������Ķ�������ַ�ת��Ϊ��������ֵ
      MOV   CX, 10
      MUL   CX              ;��10,��Ϊ��λ��
      XCHG  AX, BX
      ADD   BX, AX
      
      jmp lp1
      
lp2:  mov   buf[si],bx     ;�������Ԫ�����ڴ浥Ԫ��   
      mov   bx,0
      inc   si
      inc   si
      inc   di                ;��¼���������Ԫ�ظ���
      MOV   COUNT,DI          ;������Ԫ�ظ���
      pop   ax
      cmp   al,13
      jz    lp3
      JMP   lp1
 
    
lp3:   MOV	CX,di            ;ð�ݷ�����
	   DEC	CX               ;�Ƚϱ���
LOOP1: MOV  DX,CX            ;������ѭ����ѭ������Ҳ��������ѭ������
	   MOV	BX,0
LOOP2:
       MOV  AX, BUF[BX] 
       CMP  AX,BUF[BX+2]
       JGE	L
       XCHG  AX,BUF[BX+2]
       MOV   BUF[BX],AX
L:     ADD   BX,2 
       Loop  loop2
       MOV	  CX,DX     
       LOOP	 LOOP1

 
 
     
;lp3: mov si,0     �˶δ���������������ֵ
     ;mov cx,di
;lp5:mov ax,buf[si]
    ;cmp max,ax
    ;jge lp4
    ;mov max,ax
    ;lp4:inc si
        ;inc si
    ;loop lp5
    
    mov ah,2                ;�س�,����
    mov dl,13
    int 21h
    mov ah,2
    mov dl,10
    int 21h
   
    call tern               ;�ӳ�����ã������̺�����  
    jmp a9  
error1: mov ah,9
        lea dx,error
        int 21h
        jmp start   
a9: MOV AH,4CH
    INT 21H
    
    
    ;;;;;;;;;;;;;;;�ӳ������
TERN    	PROC			

	   ;;;;;;;;;;;;;;;��ջ�ķ�������ջ��������

            MOV CX,COUNT  
             
            MOV SI,0      ;��ַָ��仯
                
LP9:    	push cx       ;��cx����Ԫ�����
            mov BX,BUF[SI]
			mov cx,0      ;��cx���ڼ�¼ÿ��Ԫ���ڷ���ʱ��ջ����
lp11:		mov ax,BX
			cwd
			div chushu
			
			push dx       ;;;;;��ջ��������
			mov bx,ax     ;;;������
			inc cx        ;��ջ����
			cmp ax,0      ;;;�̲�Ϊ0 ��������BX��10
			jnz lp11
			
lp33:		pop dx        ;;ȫ�������꣬��ջ���δӸߵ�����ʾ
			mov ah,2
			add dl,30h
			int 21h
			loop lp33     
			
	;;;;;;;;;;;;;;;��ջ�ķ���
	         mov ah,2
             mov dl,32    ;�����Ԫ���ÿո�ָ�
             int 21h
             
	         ADD si,2     ;��ַָ���ƶ���ȡ��һ����
	         
	         POP CX
	         LOOP LP9     ;��ѭ�������������Ԫ��
			
			RET
TERN  	ENDP

CODES ENDS
    END START





