.model small 
.stack 64
.data
    arreglo db 1,2,3,4,5,6,7,8,9,10
    sumaPares dw 0
    sumaImpares dw 0
    mensajePares db 13, 10, "La suma de los numeros pares es: $"
    mensajeImpares db 13, 10,  "La suma de los numeros impares es: $"
    resultado db 0
.code 
    inicio proc 
        mov ax, @data 
        mov ds, ax 

        ; Inicializar los contadores
        mov cx, 10
        xor ax, ax
        xor bx, bx

        ; Recorrer el arreglo
        lea si, arreglo
        sumar:
            mov al, [si]
            test al, 1
            jz esPar
            add bx, ax
            jmp siguiente
        esPar:
            add ax, bx
        siguiente:
            inc si
            loop sumar

        ; Guardar las sumas
        mov sumaPares, ax
        mov sumaImpares, bx

        ; Imprimir los resultados
        mov dx, offset mensajePares
        mov ah, 09h 
        int 21h
        mov ax, sumaPares
        call imprimir

        mov dx, offset mensajeImpares
        mov ah, 09h 
        int 21h
        mov ax, sumaImpares
        call imprimir

        mov ax, 04c00h
        int 21h
    inicio endp

    ; Procedimiento para imprimir un número
    imprimir proc
        mov bx, 10
        xor cx, cx
        divide:
            xor dx, dx
            div bx
            push dx
            inc cx
            test ax, ax
        jnz divide
        print:
            pop dx
            add dl, 30h
            mov ah, 02h 
            int 21h
        loop print
        ret
    imprimir endp
end inicio 
