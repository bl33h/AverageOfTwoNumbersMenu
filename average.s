/* -----------------------------------------------
* UNIVERSIDAD DEL VALLE DE GUATEMALA
* Fabian Estuardo Juarez Tello 21440
* Sara Maria Perez Echeverria 21371
* Organización de computadoras y Assembler
* Ciclo 1 - 2022
*
* Promedio 2 numeros
 ----------------------------------------------- */

@@ codigo de assembler: se coloca en la seccion .text
	.text
	.align		2
	@@ etiqueta "main" llama a la funcion global
	.global		main
	.type		main, %function
main:
    @@ grabar registro de enlace en la pila
stmfd sp!, {lr}
/*impresion de menu y pide comando*/
Menu:
    ldr r0,=menu
    bl puts
    ldr r0,=ingreso
    bl puts
    ldr r0,=opcion
    ldr r1,=comando
    bl scanf

/*compara comandos*/
comp:
/*saltos dependiendo de caracter*/
    ldr r4,=comando
    ldrb r4,[r4]
    cmp r4, #'/'
    beq promedio
    cmpne r4, #'q'
    beq Salir
    bne ErrorCar

/* si coloca /*/
promedio:
@ingreso op2
    ldr r0,=ingreso_op
    bl puts
    ldr r0, =entrada
    ldr r1,=op2
    bl scanf
    @validacion
    cmp r0,#0
    beq Error
    @carga valores
    ldr r6, =op1
    ldr r8,[r6]
    ldr r7,=op2
    ldr r7,[r7]
    @ciclo de promedio
    mov r10,#0 /*contador*/
    cicloP:
    add r10,#1
    mul r8,r6
    cmp r10,r7
    bne cicloP
    mov r8,r8
    @guarda valor y regresa
    str r8,[r6]
    ldr r0,=res
    ldr r1,=op1
    ldr r1,[r1]
    bl printf
    b Menu
    @para ver resultado

/*si pone q sale*/
Salir:
ldr r0,=adios
bl puts
mov r0, #0
mov r3, #0
ldmfd sp!, {lr}
bx lr
.data
.align 2

op1: .word 0
op2: .word 0

error:
    .asciz "Ingreso incorrecto"
ingreso:
    .asciz "Ingrese un comando: "
ingreso_op:
    .asciz "Ingrese un valor: "
menu:
    .asciz "C A L C U L A T O R\n/. promedio de 2 numeros\nq. salir"
entrada:
    .asciz " %d"
opcion:
    .asciz " %c"
comando:
    .byte 0
adios:
    .asciz "Hasta pronto"
    