; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse2 | FileCheck %s --check-prefix=CHECK --check-prefix=SSE2
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=CHECK --check-prefix=SSE41

; A single 16-bit load + a single 16-bit store
define void @load_2_i8(<2 x i8>* %A)  {
; SSE2-LABEL: load_2_i8:
; SSE2:       # BB#0:
; SSE2-NEXT:    movzwl (%rdi), %eax
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,1,1,3]
; SSE2-NEXT:    paddq {{.*}}(%rip), %xmm0
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm0
; SSE2-NEXT:    packuswb %xmm0, %xmm0
; SSE2-NEXT:    packuswb %xmm0, %xmm0
; SSE2-NEXT:    packuswb %xmm0, %xmm0
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    movw %ax, (%rdi)
; SSE2-NEXT:    retq
;
; SSE41-LABEL: load_2_i8:
; SSE41:       # BB#0:
; SSE41-NEXT:    pmovzxbq {{.*#+}} xmm0 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero
; SSE41-NEXT:    paddq {{.*}}(%rip), %xmm0
; SSE41-NEXT:    pshufb {{.*#+}} xmm0 = xmm0[0,8,u,u,u,u,u,u,u,u,u,u,u,u,u,u]
; SSE41-NEXT:    pextrw $0, %xmm0, (%rdi)
; SSE41-NEXT:    retq
   %T = load <2 x i8>, <2 x i8>* %A
   %G = add <2 x i8> %T, <i8 9, i8 7>
   store <2 x i8> %G, <2 x i8>* %A
   ret void
}

; Read 32-bits
define void @load_2_i16(<2 x i16>* %A)  {
; SSE2-LABEL: load_2_i16:
; SSE2:       # BB#0:
; SSE2-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,1,0,3]
; SSE2-NEXT:    pshufhw {{.*#+}} xmm0 = xmm0[0,1,2,3,5,5,6,7]
; SSE2-NEXT:    paddq {{.*}}(%rip), %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,2,2,3,4,5,6,7]
; SSE2-NEXT:    movd %xmm0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE41-LABEL: load_2_i16:
; SSE41:       # BB#0:
; SSE41-NEXT:    pmovzxwq {{.*#+}} xmm0 = mem[0],zero,zero,zero,mem[1],zero,zero,zero
; SSE41-NEXT:    paddq {{.*}}(%rip), %xmm0
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE41-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,2,2,3,4,5,6,7]
; SSE41-NEXT:    movd %xmm0, (%rdi)
; SSE41-NEXT:    retq
   %T = load <2 x i16>, <2 x i16>* %A
   %G = add <2 x i16> %T, <i16 9, i16 7>
   store <2 x i16> %G, <2 x i16>* %A
   ret void
}

define void @load_2_i32(<2 x i32>* %A)  {
; SSE2-LABEL: load_2_i32:
; SSE2:       # BB#0:
; SSE2-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,1,1,3]
; SSE2-NEXT:    paddd {{.*}}(%rip), %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    movq %xmm0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE41-LABEL: load_2_i32:
; SSE41:       # BB#0:
; SSE41-NEXT:    pmovzxdq {{.*#+}} xmm0 = mem[0],zero,mem[1],zero
; SSE41-NEXT:    paddd {{.*}}(%rip), %xmm0
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE41-NEXT:    movq %xmm0, (%rdi)
; SSE41-NEXT:    retq
   %T = load <2 x i32>, <2 x i32>* %A
   %G = add <2 x i32> %T, <i32 9, i32 7>
   store <2 x i32> %G, <2 x i32>* %A
   ret void
}

define void @load_4_i8(<4 x i8>* %A)  {
; SSE2-LABEL: load_4_i8:
; SSE2:       # BB#0:
; SSE2-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3]
; SSE2-NEXT:    paddd {{.*}}(%rip), %xmm0
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm0
; SSE2-NEXT:    packuswb %xmm0, %xmm0
; SSE2-NEXT:    packuswb %xmm0, %xmm0
; SSE2-NEXT:    movd %xmm0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE41-LABEL: load_4_i8:
; SSE41:       # BB#0:
; SSE41-NEXT:    pmovzxbd {{.*#+}} xmm0 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; SSE41-NEXT:    paddd {{.*}}(%rip), %xmm0
; SSE41-NEXT:    pshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; SSE41-NEXT:    movd %xmm0, (%rdi)
; SSE41-NEXT:    retq
   %T = load <4 x i8>, <4 x i8>* %A
   %G = add <4 x i8> %T, <i8 1, i8 4, i8 9, i8 7>
   store <4 x i8> %G, <4 x i8>* %A
   ret void
}

define void @load_4_i16(<4 x i16>* %A)  {
; SSE2-LABEL: load_4_i16:
; SSE2:       # BB#0:
; SSE2-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3]
; SSE2-NEXT:    paddw {{.*}}(%rip), %xmm0
; SSE2-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,2,2,3,4,5,6,7]
; SSE2-NEXT:    pshufhw {{.*#+}} xmm0 = xmm0[0,1,2,3,4,6,6,7]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    movq %xmm0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE41-LABEL: load_4_i16:
; SSE41:       # BB#0:
; SSE41-NEXT:    pmovzxwd {{.*#+}} xmm0 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero
; SSE41-NEXT:    paddw {{.*}}(%rip), %xmm0
; SSE41-NEXT:    pshufb {{.*#+}} xmm0 = xmm0[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; SSE41-NEXT:    movq %xmm0, (%rdi)
; SSE41-NEXT:    retq
   %T = load <4 x i16>, <4 x i16>* %A
   %G = add <4 x i16> %T, <i16 1, i16 4, i16 9, i16 7>
   store <4 x i16> %G, <4 x i16>* %A
   ret void
}

define void @load_8_i8(<8 x i8>* %A)  {
; SSE2-LABEL: load_8_i8:
; SSE2:       # BB#0:
; SSE2-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; SSE2-NEXT:    paddb %xmm0, %xmm0
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm0
; SSE2-NEXT:    packuswb %xmm0, %xmm0
; SSE2-NEXT:    movq %xmm0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE41-LABEL: load_8_i8:
; SSE41:       # BB#0:
; SSE41-NEXT:    pmovzxbw {{.*#+}} xmm0 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero
; SSE41-NEXT:    paddb %xmm0, %xmm0
; SSE41-NEXT:    packuswb %xmm0, %xmm0
; SSE41-NEXT:    movq %xmm0, (%rdi)
; SSE41-NEXT:    retq
   %T = load <8 x i8>, <8 x i8>* %A
   %G = add <8 x i8> %T, %T
   store <8 x i8> %G, <8 x i8>* %A
   ret void
}
