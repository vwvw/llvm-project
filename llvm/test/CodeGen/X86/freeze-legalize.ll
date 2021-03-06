; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; Make sure that seldag legalization works correctly for freeze instruction.
; RUN: llc -mtriple=i386-apple-darwin < %s 2>&1 | FileCheck %s

define i64 @expand(i32 %x) {
; CHECK-LABEL: expand:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movl $303174162, %eax ## imm = 0x12121212
; CHECK-NEXT:    movl $875836468, %ecx ## imm = 0x34343434
; CHECK-NEXT:    movl $1448498774, %edx ## imm = 0x56565656
; CHECK-NEXT:    xorl %eax, %edx
; CHECK-NEXT:    movl $2021161080, %eax ## imm = 0x78787878
; CHECK-NEXT:    xorl %ecx, %eax
; CHECK-NEXT:    retl
  %y1 = freeze i64 1302123111658042420 ; 0x1212121234343434
  %y2 = freeze i64 6221254864647256184 ; 0x5656565678787878
  %t2 = xor i64 %y1, %y2
  ret i64 %t2
}


define <2 x i64> @expand_vec(i32 %x) nounwind {
; CHECK-LABEL: expand_vec:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    pushl %ebx
; CHECK-NEXT:    pushl %edi
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl $16843009, %ecx ## imm = 0x1010101
; CHECK-NEXT:    movl $589505315, %edx ## imm = 0x23232323
; CHECK-NEXT:    movl $303174162, %esi ## imm = 0x12121212
; CHECK-NEXT:    movl $875836468, %edi ## imm = 0x34343434
; CHECK-NEXT:    movl $1162167621, %ebx ## imm = 0x45454545
; CHECK-NEXT:    xorl %ecx, %ebx
; CHECK-NEXT:    movl $1734829927, %ecx ## imm = 0x67676767
; CHECK-NEXT:    xorl %edx, %ecx
; CHECK-NEXT:    movl $1448498774, %edx ## imm = 0x56565656
; CHECK-NEXT:    xorl %esi, %edx
; CHECK-NEXT:    movl $2021161080, %esi ## imm = 0x78787878
; CHECK-NEXT:    xorl %edi, %esi
; CHECK-NEXT:    movl %ebx, 12(%eax)
; CHECK-NEXT:    movl %ecx, 8(%eax)
; CHECK-NEXT:    movl %edx, 4(%eax)
; CHECK-NEXT:    movl %esi, (%eax)
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    popl %edi
; CHECK-NEXT:    popl %ebx
; CHECK-NEXT:    retl $4
  ; <0x1212121234343434, 0x101010123232323>
  %y1 = freeze <2 x i64> <i64 1302123111658042420, i64 72340173410738979>
  ; <0x5656565678787878, 0x4545454567676767>
  %y2 = freeze <2 x i64> <i64 6221254864647256184, i64 4991471926399952743>
  %t2 = xor <2 x i64> %y1, %y2
  ret <2 x i64> %t2
}

define i10 @promote() {
; CHECK-LABEL: promote:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movw $682, %cx ## imm = 0x2AA
; CHECK-NEXT:    movw $992, %ax ## imm = 0x3E0
; CHECK-NEXT:    addl %ecx, %eax
; CHECK-NEXT:    ## kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retl
  %a = freeze i10 682
  %b = freeze i10 992
  %res = add i10 %a, %b
  ret i10 %res
}

define <2 x i10> @promote_vec() {
; CHECK-LABEL: promote_vec:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movw $125, %ax
; CHECK-NEXT:    movw $682, %cx ## imm = 0x2AA
; CHECK-NEXT:    movw $393, %dx ## imm = 0x189
; CHECK-NEXT:    addl %eax, %edx
; CHECK-NEXT:    movw $992, %ax ## imm = 0x3E0
; CHECK-NEXT:    addl %ecx, %eax
; CHECK-NEXT:    ## kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    ## kill: def $dx killed $dx killed $edx
; CHECK-NEXT:    retl
  %a = freeze <2 x i10> <i10 682, i10 125>
  %b = freeze <2 x i10> <i10 992, i10 393>
  %res = add <2 x i10> %a, %b
  ret <2 x i10> %res
}
