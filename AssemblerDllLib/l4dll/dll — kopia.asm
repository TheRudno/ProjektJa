;JNIEXPORT void JNICALL Java_model_AsmDLLLib_BarnsleyFernAlgorithm
;  (JNIEnv *, jclass, jfloatArray, jint, jfloat, jfloat, jfloat, jfloat, jfloat, jfloat, jfloat, jfloat);

.DATA
stala0 REAL4 0.0
stala016 REAL4 0.16
stala085 REAL4 0.85
stala004 REAL4 0.04
stalaminus004 REAL4 -0.04
stala02 REAL4 0.2
stala026 REAL4 0.26
stala023 REAL4 0.23
stala022 REAL4 0.22
stalaminus015 REAL4 -0.15
stala028 REAL4 0.28
stala024 REAL4 0.24


.CODE
_DllMainCRTStartup PROC hInstDLL:DWORD, reason:DWORD, reserved1: DWORD
	mov	eax, 1
	ret
_DllMainCRTSTARTUP ENDP

;**********************************Variables in registers*****************************************
	;xmm3 startX
	;xmm4 startY
	;xmm5 x
	;xmm6 y
	;r14 licznik
	;r15 wskaznik
	;rdx probability

;**********************************Variables on stack*****************************************

;**********************************coefficients e1-f4 and argument passed in registers*****************************************
stackOffSet equ 8 + 8
env equ stackOffSet
obj equ stackOffSet + 8
pointer equ stackOffSet + 16
liczbapunktow equ stackOffSet + 24
e1 equ stackOffSet + 32
e2 equ stackOffSet + 40
e3 equ stackOffSet + 48
e4 equ stackOffSet + 56
f1 equ stackOffSet + 64
f2 equ stackOffSet + 72
f3 equ stackOffSet + 80
f4 equ stackOffSet + 88

;JNI methods
; 189 | 0x5e8	 | GetFloatArrayElements(JNIEnv *env, jfloatArray array, jboolean *isCopy)
; 197 | 0x628	 | ReleaseFloatArrayElements  (JNIEnv *env, jfloatArray array, jdouble *elems, jint mode);
;---------------------------------------------
GetFloatArrayElements EQU 5e8h
ReleaseFloatArrayElements EQU 628h


Java_model_AsmDLLLib_BarnsleyFernAlgorithm proc


	;store variables pass in register in shadow space
	mov QWORD PTR[rsp + 8], rcx
	mov QWORD PTR[rsp + 16], rdx
	mov QWORD PTR[rsp + 24], r8
	mov QWORD PTR[rsp + 32], r9

	push rbp
	mov rbp,rsp
	push r14
	push r15

	;call to  GetFloatArrayElements(JNIEnv *env, jintArray array, jboolean *isCopy)
	sub rsp, 32 + 8
	mov rbx, [rcx]
	mov rcx, env[rbp]
	mov rdx, pointer[rbp]
	mov r8, 0
	call QWORD PTR GetFloatArrayElements[rbx]
	add rsp, 32 + 8
	mov r15,rax

	mov r14, 0
	movd xmm3, r14
	movd xmm4, r14
    jmp koniec

petla:
	movss xmm5, xmm3
	movss xmm6, xmm4

	;tu jest modulo
    mov rdx, 0
	mov rax, 1234
	mov rbx, 100
	div rbx       ; Divides 1234 by 100. EDX = 34 and EAX = 12
	;modulo

	cmp rdx, 2
	jg mniejszeod86
	movss xmm1, xmm5
	xorps xmm0, xmm0
	mulss xmm1, xmm0
	movss xmm2, xmm6
	xorps xmm0, xmm0
	mulss xmm0, xmm2
	addss xmm0, xmm1
	addss xmm0, REAL4 PTR e1[rbp]
	movss xmm3, xmm0 ;xmm3 stores X value
	movss xmm1, xmm5
	xorps xmm0, xmm0
	mulss xmm1, xmm0
	movss xmm2, xmm6
	movss xmm0, stala016
	mulss xmm0, xmm2
	addss xmm0, xmm1
	addss xmm0, REAL4 PTR f1[rbp]
	movss xmm4, xmm0 ;xmm4 stores Y value
	jmp policzone

mniejszeod86:

	cmp rdx, 86
	jg mniejszeod93
	movss xmm1, xmm5
	movss xmm0, stala085
	mulss xmm1, xmm0
	movss xmm2, xmm6
	movss xmm0, stala004
	mulss xmm0, xmm2
	addss xmm0, xmm1
	addss xmm0, REAL4 PTR e2[rbp]
	movss xmm3, xmm0 ;xmm3 stores X value
	movss xmm1, xmm5
	movss xmm0, stalaminus004
	mulss xmm1, xmm0
	movss xmm2, xmm6
	movss xmm0, stala085
	mulss xmm0, xmm2
	addss xmm0, xmm1
	addss xmm0, REAL4 PTR f2[rbp]
	movss xmm4, xmm0 ;xmm4 stores Y value
	jmp policzone

mniejszeod93:

	cmp rdx, 93
	jg wiekszeod93
	movss xmm1, xmm5
	movss xmm0, stala02
	mulss xmm0, xmm1
	movss xmm2, xmm6
	movss xmm1, stala026
	mulss xmm1, xmm2
	subss xmm0, xmm1
	addss xmm0, REAL4 PTR e3[rbp]
	movss xmm3, xmm0 ;xmm3 stores X value
	movss xmm1, xmm5
	movss xmm0, stala023
	mulss xmm1, xmm0
	movss xmm2, xmm6
	movss xmm0, stala022
	mulss xmm0, xmm2
	addss xmm0, xmm1
	addss xmm0, REAL4 PTR f3[rbp]
	movss xmm4, xmm0 ;xmm4 stores Y value
	jmp policzone

wiekszeod93:

	movss xmm1, xmm5
	movss xmm0, stalaminus015
	mulss xmm1, xmm0
	movss xmm2, xmm6
	movss xmm0, stala028
	mulss xmm0, xmm2
	addss xmm0, xmm1
	addss xmm0, REAL4 PTR e4[rbp]
	movss xmm3, xmm0 ;xmm3 stores X value
	movss xmm1, xmm5
	movss xmm0, stala026
	mulss xmm1, xmm0
	movss xmm2, xmm6
	movss xmm0, stala024
	mulss xmm0, xmm2
	addss xmm0, xmm1
	addss xmm0, REAL4 PTR f4[rbp]
	movss xmm4, xmm0 ;xmm4 stores Y value

policzone:

	mov rax, r14
	cdqe
	movss DWORD PTR [r15+rax*4], xmm3
	inc r14
	mov rax, r14
	cdqe
	movss DWORD PTR [r15+rax*4], xmm4
	inc r14

koniec:

	cmp r14, liczbapunktow[rbp]
	jl petla

	;call to  ReleaseFloatArrayElements  (JNIEnv *env, jfloatArray array, jdouble *elems, jint mode);
	sub rsp, 32 + 8
	mov rdi, env[rbp]
	mov rbx, [rdi]
	mov rcx, rdi
	mov rdx, pointer[rbp]
	mov r8, r15
	mov r9, 1
	call QWORD PTR ReleaseFloatArrayElements[rbx]
	add rsp, 32 + 8

	pop r15
	pop r14
	pop rbp
	ret

Java_model_AsmDLLLib_BarnsleyFernAlgorithm endp

END
;-------------------------------------------------------------------------
