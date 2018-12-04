includelib libcmt.lib
includelib libvcruntime.lib
includelib libucrt.lib
includelib legacy_stdio_definitions.lib

.DATA
e1 DWORD 0
e2 DWORD 0
e3 DWORD 0
e4 DWORD 0
f1 DWORD 0
f2 DWORD 0
f3 DWORD 0
f4 DWORD 0
licznik DWORD 0
liczbapunktow DWORD 0
stala0 DWORD 0.0
stala016 DWORD 0.16 
stala085 DWORD 0.85
stala004 DWORD 0.04
stalaminus004 DWORD  -0.04
stala02 DWORD 0.2
stala026 DWORD 0.26
stala023 DWORD 0.23
stala022 DWORD 0.22
stalaminus015 DWORD -0.15
stala028 DWORD 0.28
stala024 DWORD 0.24
startX DWORD 0
startY DWORD 0
x DWORD 0
y DWORD 0
probability DWORD 0


.CODE
_DllMainCRTStartup PROC hInstDLL:DWORD, reason:DWORD, reserved1: DWORD
	mov	eax, 1 
	ret
_DllMainCRTSTARTUP ENDP

extern rand:NEAR
extern srand:NEAR
extern time:NEAR


Java_model_AssemblerDllLibrary_BarnsleyFernAlgorithm proc

  push rbp
  mov rbp, rsp
  sub rsp, 80
  mov QWORD PTR [rbp-40], rdi
  mov liczbapunktow, esi ;zapisanie licznika
  movss e1, xmm0 ;zapisanie e1
  movss e2, xmm1 ;zapisanie e2
  movss e3, xmm2 ;zapisanie e3
  movss e4, xmm3 ;zapisanie e4
  movss f1, xmm4 ;zapisanie f1
  movss f2, xmm5 ;zapisanie f2
  movss f3, xmm6 ;zapisanie f3
  movss f4, xmm7 ;zapisanie f4
  mov edi, 0
  call time
  mov edi, eax
  call srand
  mov licznik, 0
  jmp koniec

petla:
  mov eax, startX
  mov x, eax
  mov eax, startY
  mov y, eax

  ;jakis dziwny szit modulo z rand
  call rand
  mov ecx, eax
  mov edx, 1374389535
  mov eax, ecx
  imul edx
  sar edx, 5
  mov eax, ecx
  sar eax, 31
  sub edx, eax
  mov eax, edx
  mov probability, eax
  mov eax, probability
  imul eax, eax, 100
  sub ecx, eax
  mov eax, ecx
  mov probability, eax
  ;koniec tego gowna

  cmp probability, 2
  jg mniejszeod86
  movss xmm1, x
  xorps xmm0, xmm0
  mulss xmm1, xmm0
  movss xmm2, e1
  xorps xmm0, xmm0
  mulss xmm0, xmm2
  addss xmm0, xmm1
  addss xmm0, DWORD PTR [rbp-48]
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

  mov eax, licznik
  cdqe
  lea rdx, [0+rax*4]
  mov rax, QWORD PTR [rbp-40]
  add rdx, rax
  mov eax, startX
  mov DWORD PTR [rdx], eax
  mov eax, licznik
  cdqe
  add rax, 1
  lea rdx, [0+rax*4]
  mov rax, QWORD PTR [rbp-40]
  add rdx, rax
  mov eax, startY
  mov DWORD PTR [rdx], eax
  add licznik, 2

koniec:

  mov eax, licznik
  cmp eax, liczbapunktow
  jl petla
  leave
  ret

Java_model_AssemblerDllLibrary_BarnsleyFernAlgorithm endp

END
;-------------------------------------------------------------------------