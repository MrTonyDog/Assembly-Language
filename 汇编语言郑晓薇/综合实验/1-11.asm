;�ۺ�ʵ��:      ѧ������ϵͳ
assume cs:code,ds:data,ss:stack
data segment
    Welcome db 0ah,0dh,'Welcome To The StudentManager System!!!!!',0ah,0dh,'$'
    buf0 db 'The menu:',0ah,0dh,'$'
    buf1 db 'Input 1:   Score Entry',0ah,0dh,'$' ;�ɼ�¼�벢���
    buf2 db 'Input 2:   Sorted data output',0ah,0dh,'$'     ;����������������ɼ������Σ�
    buf3 db 'Input 3:   Search Student',0ah,0dh,'$'         ;��ѧ�Ų���ѧ������ѡ���Ƿ��޸ĳɼ�
    buf30 db 'Input 4:   exit the system',0ah,0dh,'$'
    buf4 db 'Input the num:','$'
    buf5 db 0ah,0dh,'---------------------------------------------------',0ah,0dh,'$'   ;����
    buf6 db 'Id  Name       Score   Rank','$'
    buf7 db 0ah,0dh,'Search OutCome is: ',0ah,0dh,'$'
    buf8 db 0ah,0dh,'Input The New Score: ',0ah,0dh,'$'
    buf9 db 0ah,0dh,'The Score is Change!: ',0ah,0dh,'$'
    buf10 db 0ah,0dh,'Do Your Want To Change The Score ?',0ah,0dh,'(Y/N)',0ah,0dh,'$'
    buf11 db 0ah,0dh,'Your Have Been Input The Score!!!   ',0ah,0dh,'If Your Want To Again Input The Student Score ',0ah,0dh,'Your Must Restart The System!!!',0ah,0dh,'$'
    buf12 db 0ah,0dh,'You Must Enter The Score Before Query!!!  ',0ah,0dh,'$'
    buf13 db 0ah,0dh,'Input 1:  Use Score To Search  ',0ah,0dh,'Input 2:  Use StudentId To Search  ',0ah,0dh,'$'
    buf14 db 0ah,0dh,'Input the id:','$'
    buf15 db 0ah,0dh,'Thank You Use!!!!!!',0ah,0dh,'$'
    errorbuf db 0ah,0dh,'Please enter the correct number!',0ah,0dh,'$'  ;������ʾ
    notice1 db 0ah,0dh,'Please input the student num: ','$'
    notice2 db 0ah,0dh,'input the student score to search: ','$'
    notice3 db 0ah,0dh,'Search is fail! Dont Find! ',0ah,0dh,'$'
    name1 db 'name: ','$'         ;����
    score1 db 'score: ','$'       ;����
    ranking db 'ranking: ','$'   ;����

    ;stu1 db 7 dup (?),100,1,0       ;ģ��: ����7,�ɼ�1,����1,ѧ��1,Flag1 
                                    ;���ȹ�11

    stunum db ?                   ;ͳ���ж��ٸ�ѧ��
    middleVar dw ?                   ;�м�ֵ
    searchOk db ?                 ;�Ƿ��ѯ��
    functionOk db ?               ;��һ�ι��ܼ�¼

    student1    db ?,?,?,?,?,?,?,?,?,?,?
                db ?,?,?,?,?,?,?,?,?,?,?
                db ?,?,?,?,?,?,?,?,?,?,?
                db ?,?,?,?,?,?,?,?,?,?,?
                db ?,?,?,?,?,?,?,?,?,?,?
                db ?,?,?,?,?,?,?,?,?,?,?
                db ?,?,?,?,?,?,?,?,?,?,?
                db ?,?,?,?,?,?,?,?,?,?,?
                db ?,?,?,?,?,?,?,?,?,?,?

    StudentScore db ?,?,?,?,?,?,?,?,?
    StudentFlag  db 0,0,0,0,0,0,0,0,0
data ends

stack segment
    dw 20 dup (?)
stack ends

code segment
start:  mov ax,data
        mov ds,ax
        mov ax,stack
        mov ss,ax
        mov sp,28H

        call WelcomeSystem
menu:   call CR2
        call output1    ;����˵�
        call handle1    ;���� ��������ֶ�Ӧ�Ĳ˵�����  ,�������al��
        cmp al,1
        jz function1
        cmp al,2
        jz function2
        cmp al,3
        jz function3
        cmp al,4
        jz over1

function1:cmp ds:byte ptr [functionOk],0
          jz menu1
          call css1                     ;ûʲô�õ���ʾ                
          jmp menu

menu1:    call InputScore               ;����ɼ�
          call css4                     ;ûʲô�õ���ʾ
          jmp menu

function2:cmp ds:byte ptr [functionOk],1
          jz menu2
          mov ah,9
          call css2                   ;ûʲô�õ���ʾ            
          jmp menu

menu2:    call UpdateScore            ;���³ɼ�
          call ClearnFlag             ;������
          call SortData1              ;��ѧ���ɼ���������, ��С����
          call RankData1              ;�������������
          call css4                   ;ûʲô�õ���ʾ  
          call CR2
          jmp menu

function3:call css3                   ;ûʲô�õ���ʾ  
          mov ah,1
          int 21h
          cmp ds:byte ptr [functionOk],1
          jz menu3
          call css2                    
          jmp menu
 menu3:   cmp al,'1'
          jz scmethod1
          cmp al,'2'
          jz scmethod2

          jmp menu
scmethod1:call SearchStudent1       ;���ɼ�����
          jmp scmethod0             
scmethod2:call SearchStudent2       ;��ѧ�Ų���
scmethod0:  call css4
            call CR2
            jmp menu

over1:  call CR2
        mov ah,9
        mov dx,offset buf15
        int 21h
        mov ax,4c00h
        int 21h
;����Ϊ������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;����Ϊ�����ӳ��� 
css1    proc far
          mov ah,9
          mov dx,offset buf5
          int 21h          
          mov ah,9
          mov dx,offset buf11
          int 21h 
          mov ah,9
          mov dx,offset buf5
          int 21h
          ret
css1    endp
css2    proc far
          mov dx,offset buf5
          int 21h          
          mov ah,9
          mov dx,offset buf12
          int 21h 
          mov ah,9
          mov dx,offset buf5
          int 21h
          ret
css2    endp
css3    proc far
          mov ah,9
          mov dx,offset buf5
          int 21h 
          mov ah,9
          mov dx,offset buf13
          int 21h 
          mov ah,9
          mov dx,offset buf5
          int 21h
          ret
css3 endp
css4    proc far
          mov ah,9
          mov dx,offset buf5
          int 21h
css4 endp
WelcomeSystem proc far
        mov ah,9
        mov dx,offset Welcome
        int 21h
        ret
WelcomeSystem endp
SearchStudent2 proc far
        push dx
        push cx 
        push bx
        push ax
        push si
        
        mov ah,9
        mov dx,offset buf14
        int 21h

        mov ah,1
        int 21h
        cmp al,'0'
        jb error2 
        cmp al,'9'
        ja error2

        call CR2
        sub al,30h
        mov bx,0
        mov cx,0
        mov cl,ds:byte ptr [stunum]
loop5:  cmp al,ds:byte ptr [student1+bx+9]
        jz ScoreOutPut1                         ;����ҵ��˸�ѧ��
loop50: add bx,11
        loop loop5
        jmp over11

ScoreOutPut1:   mov ah,9
                mov dx,offset buf5
                int 21h
                mov ah,9
                mov dx,offset buf7
                int 21h
                call CR2
                mov ah,9
                mov dx,offset buf5
                int 21h
                mov ah,9
                mov dx,offset buf6
                int 21h
                call CR2

                call ScoreOutPut                ;���ѧ���ɼ�
                call ChangeStudent              ;�޸�ѧ���ɼ�
                mov ah,9
                mov dx,offset buf5
                int 21h 
                call UpdateScore                ;����ѧ���ɼ�
                call ClearnFlag                 ;������
                call SortData1                  ;����
                call RankData1                  ;��������
                jmp loop50

error2: mov ah,9
        mov dx,offset errorbuf
        int 21h

over11: pop si
        pop ax
        pop bx
        pop cx
        pop dx        
        ret
SearchStudent2 endp
ClearnFlag proc far
        push ax
        push si
        push cx
        push bx
        mov cx,9
        mov si,0
        mov bx,0

clear:  mov ds:byte ptr [student1+bx+10],0
        add bx,11
        loop clear

        pop bx
        pop cx
        pop si
        pop ax
        ret
ClearnFlag endp

SearchStudent1 proc far
        push dx
        push cx 
        push bx
        push ax
        push si
        mov ds:byte ptr [searchOk],0
        mov ah,9
        mov dx,offset notice2
        int 21h
        call control1
        mov ah,9
        mov dx,offset buf5
        int 21h
        mov ah,9
        mov dx,offset buf7
        int 21h

        mov cx,0
        mov bx,0
        mov cl,ds:byte ptr [stunum]
search3:cmp al,ds:byte ptr [student1+bx+7]
        jz search3Success                       ;�����ѯ����        
next4:  add bx,11
        loop search3

        call CR2
        cmp ds:byte ptr [searchOk],0
        jz SearchOk1 
        jmp over6

SearchOk1:mov ah,9
          mov dx,offset notice3
          int 21h
          jmp over6

search3Success: call CR2
                mov ds:byte ptr [searchOk],1
                mov ah,9
                mov dx,offset buf6
                int 21h
                call CR2
                 
                call ScoreOutPut
                call ChangeStudent
                mov ah,9
                mov dx,offset buf5
                int 21h 
                call UpdateScore
                call ClearnFlag              
                call SortData1
                call RankData1
                jmp next4

over6:  pop si
        pop ax
        pop bx
        pop cx
        pop dx        
        ret
SearchStudent1 endp

UpdateScore proc far
        push cx
        push bx
        push si
        push dx
        mov si,0
        mov bx,0
        mov dx,0
        mov cl,ds:byte ptr [stunum]

loop3:  mov dl,ds:byte ptr [student1+bx+7]
        mov ds:byte ptr [StudentScore+si],dl
        add bx,11
        inc si
        loop loop3

        pop dx
        pop si
        pop bx
        pop cx
over10: ret 
UpdateScore endp

ChangeStudent proc far
        push ax
        push bx
        push cx
        push dx
        push si
        mov ah,9
        mov dx,offset buf10
        int 21h
        mov ah,1
        int 21h
        cmp al,'y'
        jz ChangeOk2
        jmp over7

ChangeOk2:                          ;���ȷ��Ҫ�޸� 
            mov ah,9
            mov dx,offset buf8
            int 21h
            mov ax,0
            call control1
            cmp ax,100          ;����ǷǷ��ɼ�
            ja over13            
            mov ds:byte ptr [student1+bx+7],al
            call CR2
            mov ah,9
            mov dx,offset buf9
            int 21h
            jmp over7
            
    over13: mov ah,9
            mov dx,offset errorbuf
            int 21h
            jmp ChangeOk2

    over7: 
            pop si
            pop dx
            pop cx
            pop bx
            pop ax

        ret
ChangeStudent endp

RankData1 proc far
            push ax
            push bx
            push cx
            push dx
            push si
            
            push ax
            call CR2
            mov ah,9
            mov dx,offset buf6
            int 21h
            call CR2
            pop ax
            mov cl,ds:byte ptr [stunum] ;ѭ������Ϊѧ������
            mov si,0 
            mov bx,0
            mov dx,0            
loop2:      mov al,ds:byte ptr [StudentScore+si]    ;for (i = 0; i < x;i++)
            call fosearch                                 ;for (j = i; j < x ;j++)
            inc si 

            loop loop2
            jmp over9

fosearch proc far
        push cx
        push bx
        push si         

        mov cl,ds:byte ptr [stunum]
search1:cmp al,ds:byte ptr [student1+bx+7]    ;�Գɼ����в���
        jz FindSuccess
search2:
        add bx,11
        loop search1
        jmp over5

FindSuccess:    
                cmp ds:byte ptr [student1+bx+10],1         ;������޸Ĺ�������ת��search2
                jz  search2
                mov ds:byte ptr [student1+bx+10],1

                mov dx,si
                inc dl
                add dl,30h      ;��ΪASCII��
                mov ds:byte ptr [student1+bx+8],dl      ;��������
                call ScoreOutPut
                jmp over5
        
over5:  
        pop si
        pop bx
        pop cx
        ret
fosearch endp 
over9:      pop si
            pop dx
            pop cx
            pop bx
            pop ax 
            ret       
RankData1 endp

ScoreOutPut  proc far      
        push dx
        push cx
        push bx
        push ax
        push si

        mov ah,2                            
        mov dl,ds:byte ptr [student1+bx+9]
        add dl,30h
        int 21h
        mov cx,4
loop4:  mov ah,2
        mov dl,20h
        int 21h
        loop loop4

        mov cx,7
        mov si,0
nameout:mov ah,2                            ;�������
        mov dl,ds:byte ptr [student1+bx+si]
        int 21h
        inc si
        loop nameout

        mov ah,2
        mov dl,09h
        int 21h

        mov dx,0
        mov ax,0
        mov al,ds:byte ptr [student1+bx+7]  ;����ɼ�
        call stackdiv16

        mov ah,2
        mov dl,09h
        int 21h

        mov ah,2
        mov dl,ds:byte ptr [student1+bx+8]  ;�������
        int 21h
        call CR2

        pop si
        pop ax
        pop bx
        pop cx
        pop dx
        
        ret
ScoreOutPut endp

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
             
next3:        ;call CR2          ;�س��ͻ���
              
              
              pop si     
              pop dx       
              pop bx
              ret


stackdiv16 endp

SortData1 proc far
            push ax
            push bx
            push cx
            push dx
            push si
            mov cl,ds:byte ptr [stunum] ;ѭ������Ϊѧ������
            mov si,0             
x1:         mov al,ds:byte ptr [StudentScore+si]     ;for (i = 0; i < x;i++)
            call x2                                 ;for (j = i; j < x ;j++)
            inc si 
            loop x1
            jmp  over8

x2 proc far
        push cx
        push si     
        mov dx,si
        mov ds:byte ptr [middleVar],dl

x3:     
        cmp al,ds:byte ptr [StudentScore+si]     ;if(a[i]<a[j])
        jb change1      ;����ֵ         
change2: inc si
        loop x3
        
        jmp over3
        
change1:push si
        mov bl,al
        mov al,ds:byte ptr [StudentScore+si]

        mov si,ds:word ptr [middleVar]              ;;;;;;;;�ؼ�����,��a[j]����a[i]
        mov ds:byte ptr [StudentScore+si],al         ;;;;;;;;�ؼ�����,��a[j]����a[i]        
        pop si
        mov ds:byte ptr [StudentScore+si],bl
      
        jmp change2

        
over3:  pop si
        pop cx
        ret
x2 endp 
over8:  pop si
        pop dx
        pop cx
        pop bx
        pop ax
        ret      
SortData1 endp

output1 proc far
        mov ah,9
        mov dx,offset buf0
        int 21h
        mov ah,9
        mov dx,offset buf1
        int 21h
        mov ah,9
        mov dx,offset buf2
        int 21h
        mov ah,9
        mov dx,offset buf3
        int 21h
        mov ah,9
        mov dx,offset buf30
        int 21h
        mov ah,9
        mov dx,offset buf4
        int 21h
        ret
output1 endp

handle1 proc far
Input1: mov ah,1
        int 21h

        cmp al,'1'
        jb error1
        cmp al,'4'
        ja error1
        sub al,30h      ;��Ϊ������
        jmp over2

error1: mov ah,9
        mov dx,offset errorbuf
        int 21h
        jmp Input1
over2:  ret
handle1 endp

output2 proc far
    mov ah,9
    mov dx,offset buf5
    int 21h
output2 endp

control1 proc far			
		
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
	shl bl, 1       ;��bl�е�������������,ʹbl=8
	add bx, dx
	add bx, ax      
        ret
change endp

control1 endp

InputScore proc far     ;�ɼ�¼�벢���
                mov ah,9
                mov dx,offset notice1
                int 21h
                mov ah,1
                int 21h
		cmp al, '0'				
                jb over4		;���������ַ��в������ֵ�ascii��ֵ
                cmp al, '9'		
                ja over4		;���������ַ��в������ֵ�ascii��ֵ
                sub al,30h
                mov ds:byte ptr [stunum],al     ;ͳ���ж��ٸ�ѧ��
                mov cl,al

                mov si,0
                mov bx,0
studentnum1:    call CR2        
                mov ah,9
                mov dx,offset name1
                int 21h
                push cx

                push si
        Restart:mov cx,7
                mov si,0
        loop1:  mov ah,1
                int 21h
                cmp al,0dh      ;�����س�����һ��λ��
                jz go1
                .if al>='a'
                        .if al<='z'
                                mov ds:byte ptr [student1+si+bx],al     ;ASCII��ֱ�Ӵ���
                                jmp test1
                        .endif
                .endif

                .if al>='A'
                        .if al<='Z'
                                mov ds:byte ptr [student1+si+bx],al     ;ASCII��ֱ�Ӵ���
                                jmp test1
                        .endif
                .endif
                sub si,1
                inc cx
        test1:  inc si
                loop loop1      ;��������
                

        go1:    pop si
                pop cx
        go2:    call CR2
                mov ah,9
                mov dx,offset score1
                int 21h
                call control1       ;����ɼ�
                cmp ax,100          ;����ǷǷ��ɼ�
                ja over12
                mov ds:byte ptr [student1+bx+7],al      ;����ɼ�
                mov ds:byte ptr [StudentScore+si],al    ;����ɼ�

                push dx
                mov dx,si
                inc dx
                mov ds:byte ptr [student1+bx+9],dl     ;�Զ����ѧ��
                pop dx

                inc si
                add bx,11
                loop studentnum1

                call lock1
                call CR2
                jmp over4
         over12:mov ah,9
                mov dx,offset errorbuf
                int 21h
                jmp go2
         over4: ret
InputScore endp

lock1 proc far
    mov ds:byte ptr [functionOk],1
    ret
lock1 endp

        CR2 proc far    ;����س��ͻ���
                push ax
                push dx
                mov ah,2
                mov dl,0ah
                int 21h   
                mov ah,2
                mov dl,0dh
                int 21h
                pop dx
                pop ax
                ret
        CR2 endp

code ends
end start