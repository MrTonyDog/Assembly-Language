;coding:gbk
;ʵ���壬��֧������Ƶĵ����⣺
;��Ŀ:
;���ڴ�����buf��Ԫ��ʼ�����������������10��
;ѧ���ķ������Ա��Ƴ���ͳ������90~100�֣�80~89�֣�60~79��
;��60�������߸��ж����ˣ����ѽ���ֱ���
;��S9,S8,S7��S6�У�����ʾ��������

;90~100�֣�80~89�֣�60~79��,60������.

assume cs:code,ds:data
data segment                     ;0a:���� , 0d:�س�,�ص���һ�еĶ�ͷ
   x db 'INPUT  YOUR NAME:','$'
   y db 39,91,92,80,81,82,60,61,62,50         ;ֻ������6���ַ�,��ΪҪ��ȥ0dh��$(�ڴ�����ʾΪ: 0dh '$') 8-2 = 6
   z db '?(y/n)','$'
data ends
code segment
start:      mov ax,data
            mov ds,ax
            
            mov cx,10
            mov bx,offset y
     main:  cmp ds:byte ptr [bx],60                ;60������
            jb  s10
            
            cmp ds:byte ptr [bx],60                ;a[i]>=60
            jae s21

        s30:cmp ds:byte ptr [bx],80                ;80�ּ�����
            jae s31

        s40:cmp ds:byte ptr [bx],90                ;a[i]>=90
            jae s41

            loop main
            jmp over

       s10: mov ah,2
            mov dl,'6'                      ;a[i]<60
            int 21h
            cmp cx,0
            ja near ptr con1
     con2:  inc bx
            jmp main



       s21: cmp ds:byte ptr [bx],79          
            jbe s22                         ;a[i]>=60&&a[i]<=79
            jmp s30
        
       s22:  
            mov ah,2
            mov dl,'7'
            int 21h
             cmp cx,0
            ja near ptr con1
     con2:  inc bx            
            jmp main

       s31: cmp ds:byte ptr [bx],89
            jbe s32                         ;a[i]>=80&&a[i]<=89
            jmp s40

       s32: mov ah,2                        ;a[i]>=80&&a[i]<=89
            mov dl,'8'
            int 21h
            cmp cx,0
            ja near ptr con1
     con2:  inc bx
            jmp main


       s41: cmp ds:byte ptr [bx],100
            jbe s42                         ;a[i]>=90&&a[i]<=100
            jmp s50
        
       s42: mov ah,2                        
            mov dl,'9'                      ;a[i]>=90&&a[i]<=100
            int 21h
            cmp cx,0
            ja con1
      inc bx
            jmp main
       
       s50: mov ah,2
            mov dl,'b'
            int 21h
            cmp cx,0
            ja con1
       inc bx           
            jmp main
    


       over:mov ax,4c00h
            int 21h

con1:      dec cx
           ret

      CR1:  mov ah,2                            ;����
            mov dl,0ah
            int 21h
            ret

code ends   
end start