name "JOGO DA VELHA"
org 100h
 
 .DATA
 
    grid db '1','2','3'  
         db '4','5','6'
         db '7','8','9'
         
    player db ?  
    
    
    welcomeMsg db 'JOGO DA VELHA $'   
    inputMsg db 'Entre a casa que deseja jogar, jogador: $'
    draw db 'Empate! $'
    won db 'Ganhou: $'  
    
 .CODE
    main:
         
        mov cx,9              
        x:   
            call clearScreen  
            call printWelcomeMsg
            call printGrid
             
            
            mov bx, cx
            and bx, 1       
            cmp bx, 0
            je isEven       
            mov player,'x'  
            jmp endif
            isEven:
            mov player,'o'  
            endif:
            
            notValid:
            call printNewLine
            call printInputMsg
            call readInput 
            
            push cx
            mov cx, 9
            mov bx, 0           
            y:
            cmp grid[bx],al     
            je update           
            jmp continue
            update:
            mov dl,player       
            mov grid[bx],dl  
            continue:
            inc bx
            loop y
            pop cx
            call checkwin        
        loop x           
        
    
        call printDraw   
        
        programEnd:   
        
        mov     ah, 0    
        int     16h      
    ret              
    
           
        
        
        
        
        printGrid:
            push cx      
            mov bx,0
            mov cx,3
            x1:
                call printNewLine 
                push cx          
                mov cx, 3
                x2:
                    mov dl, grid[bx]  
                    sub al, 30h   
                    mov ah, 2h   
                    int 21h
                    call printSpace              
                    inc bx       
                loop x2
                pop cx                       
            loop x1
            pop cx
            call printNewLine                        
        ret 
        
        printNewLine:
            mov dl, 0ah       
            mov ah, 2        
            int 21h
            mov dl, 13       
            mov ah, 2        
            int 21h
        ret 
        
        printSpace:
            mov dl, 32       
            mov ah, 2         
            int 21h
        ret
        
        readInput:
           mov ah, 1 
           int 21h
           
           cmp al,'1'
           je valid
           cmp al,'2'
           je valid
           cmp al,'3'
           je valid
           cmp al,'4'
           je valid
           cmp al,'5'
           je valid
           cmp al,'6'
           je valid
           cmp al,'7'
           je valid
           cmp al,'8'
           je valid
           cmp al,'9'
           je valid
           jmp notValid
           valid:        
        ret
        
       printWelcomeMsg:
            lea dx, welcomeMsg  
            mov ah, 9             
            int 21h
        ret
        
       printDraw:
            call printNewLine
            lea dx, draw  
            mov ah, 9             
            int 21h
        ret
        
       printWon:   
            call printNewLine
            call printGrid 
            lea dx, won  
            mov ah, 9             
            int 21h
            mov dl, player 
            sub al, 30h   
            mov ah, 2h  
            int 21h
            jmp programEnd
        ret   
        
        printInputMsg:
            lea dx, inputMsg    
            mov ah, 9             
            int 21h
            mov dl, player       
            sub al, 30h   
            mov ah, 2h  
            int 21h 
            call printSpace
        ret
        
        checkWin:
            mov bl, grid[0]
            cmp bl, grid[1]              
            jne skip1      
            cmp bl, grid[2]  
            jne skip1 
            call printWon
            skip1:
            
            mov bl, grid[3]
            cmp bl, grid[4]              
            jne skip2  
            cmp bl, grid[5]  
            jne skip2
            call printWon
            skip2: 
            
            mov bl, grid[6]
            cmp bl, grid[7]              
            jne skip3  
            cmp bl, grid[8]  
            jne skip3
            call printWon
            skip3: 
            
            mov bl, grid[0]
            cmp bl, grid[3]              
            jne skip4  
            cmp bl, grid[6]  
            jne skip4
            call printWon
            skip4:   
            
            mov bl, grid[1]
            cmp bl, grid[4]              
            jne skip5  
            cmp bl, grid[7]  
            jne skip5
            call printWon
            skip5:
            
            mov bl, grid[2]
            cmp bl, grid[5]              
            jne skip6  
            cmp bl, grid[8]  
            jne skip6
            call printWon
            skip6:
            
            mov bl, grid[0]
            cmp bl, grid[4]              
            jne skip7  
            cmp bl, grid[8]  
            jne skip7
            call printWon
            skip7:
            
            mov bl, grid[2]
            cmp bl, grid[4]              
            jne skip8  
            cmp bl, grid[6]  
            jne skip8
            call printWon
            skip8:             
        ret
        
        clearScreen:
            mov ax, 3   
            int 10h
        ret    
    end main 