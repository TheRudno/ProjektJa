includelib libcmt.lib
includelib libvcruntime.lib
includelib libucrt.lib
includelib legacy_stdio_definitions.lib

.DATA
e1 REAL4 0.
e2 REAL4 0.
e3 REAL4 0.
e4 REAL4 0.
f1 REAL4 0.
f2 REAL4 0.
f3 REAL4 0.
f4 REAL4 0.
licznik QWORD 0
liczbapunktow QWORD 0
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
startX REAL4 0.0
startY REAL4 0.0
x REAL4 0.0
y REAL4 0.0
tmp QWORD 0
probability DWORD 0
wskaznik QWORD 0
env QWORD 0
returnAdress QWORD 0

.CODE
_DllMainCRTStartup PROC hInstDLL:DWORD, reason:DWORD, reserved1: DWORD
	mov	eax, 1
	ret
_DllMainCRTSTARTUP ENDP

extern rand:NEAR
extern srand:NEAR
extern time:NEAR

Java_model_AsmDLLLib_BarnsleyFernAlgorithm proc

;JNIEXPORT void JNICALL Java_model_AsmDLLLib_BarnsleyFernAlgorithm
;  (JNIEnv *, jclass, jfloatArray, jint, jfloat, jfloat, jfloat, jfloat, jfloat, jfloat, jfloat, jfloat);

  mov env,rcx ;get JNIEnv variable
  mov wskaznik, r8 ;get jfloatArray pointer
  mov liczbapunktow, r9  ;get jint points count
  movss xmm0, REAL4 PTR[rsp + 40]
  movss e1, xmm0 ;zapisanie e1 ;get jfloat e1
  movss xmm0, REAL4 PTR[rsp + 48]
  movss e2, xmm0 ;zapisanie e2 ;get jfloat e2
  movss xmm0, REAL4 PTR[rsp + 56]
  movss e3, xmm0 ;zapisanie e3 ;get jfloat e3
  movss xmm0, REAL4 PTR[rsp + 64]
  movss e4, xmm0 ;zapisanie e4 ;get jfloat e4
  movss xmm0, REAL4 PTR[rsp + 72]
  movss f1, xmm0 ;zapisanie f1 ;get jfloat f1
  movss xmm0, REAL4 PTR[rsp + 80]
  movss f2, xmm0 ;zapisanie f2 ;get jfloat f2
  movss xmm0, REAL4 PTR[rsp + 88]
  movss f3, xmm0 ;zapisanie f3 ;get jfloat f3
  movss xmm0, REAL4 PTR[rsp + 96]
  movss f4, xmm0 ;zapisanie f4 ;get jfloat f4
  ;mov edi, 0
  ;call time
  ;mov edi, eax
  ;call srand
  jmp koniec

petla:
  mov eax, startX
  mov x, eax
  mov eax, startY
  mov y, eax

  ;tu ma byc modulo
  mov probability, 5
  cmp probability, 2
  jg mniejszeod86
  movss xmm1, x
  xorps xmm0, xmm0
  mulss xmm1, xmm0
  movss xmm2, y
  xorps xmm0, xmm0
  mulss xmm0, xmm2
  addss xmm0, xmm1
  addss xmm0, e1
  movss startX, xmm0
  movss xmm1, x
  xorps xmm0, xmm0
  mulss xmm1, xmm0
  movss xmm2, y
  movss xmm0, stala016
  mulss xmm0, xmm2
  addss xmm0, xmm1
  addss xmm0, f1
  movss startY, xmm0
  jmp policzone

mniejszeod86:

  cmp probability, 86
  jg mniejszeod93
  movss xmm1, x
  movss xmm0, stala085
  mulss xmm1, xmm0
  movss xmm2, y
  movss xmm0, stala004
  mulss xmm0, xmm2
  addss xmm0, xmm1
  addss xmm0, e2
  movss startX, xmm0
  movss xmm1, x
  movss xmm0, stalaminus004
  mulss xmm1, xmm0
  movss xmm2, y
  movss xmm0, stala085
  mulss xmm0, xmm2
  addss xmm0, xmm1
  addss xmm0, f2
  movss startY, xmm0
  jmp policzone

mniejszeod93:

  cmp probability, 93
  jg wiekszeod93
  movss xmm1, x
  movss xmm0, stala02
  mulss xmm0, xmm1
  movss xmm2, y
  movss xmm1, stala026
  mulss xmm1, xmm2
  subss xmm0, xmm1
  addss xmm0, e3
  movss startX, xmm0
  movss xmm1, x
  movss xmm0, stala023
  mulss xmm1, xmm0
  movss xmm2, y
  movss xmm0, stala022
  mulss xmm0, xmm2
  addss xmm0, xmm1
  addss xmm0, f3
  movss startY, xmm0
  jmp policzone

wiekszeod93:

  movss xmm1, x
  movss xmm0, stalaminus015
  mulss xmm1, xmm0
  movss xmm2, y
  movss xmm0, stala028
  mulss xmm0, xmm2
  addss xmm0, xmm1
  addss xmm0, e4
  movss startX, xmm0
  movss xmm1, x
  movss xmm0, stala026
  mulss xmm1, xmm0
  movss xmm2, y
  movss xmm0, stala024
  mulss xmm0, xmm2
  addss xmm0, xmm1
  addss xmm0, f4
  movss startY, xmm0

policzone:

  mov rax, licznik
  cdqe
  mov rcx, wskaznik
  movss xmm0, startX
  movss DWORD PTR [rcx+rax*4], xmm0
  inc licznik
  mov rax, licznik
  cdqe
  mov rcx, wskaznik
  movss xmm0, startY
  movss DWORD PTR [rcx+rax*4], xmm0
  inc licznik

koniec:

  mov rax, licznik
  cmp rax, liczbapunktow
  jl petla

  ret

Java_model_AsmDLLLib_BarnsleyFernAlgorithm endp

END
;-------------------------------------------------------------------------
