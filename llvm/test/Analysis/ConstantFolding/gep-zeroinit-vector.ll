; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -constprop -S -o - | FileCheck %s

; Testcase that point out faulty bitcast that cast between different sizes.
; See "bitcast ([1 x %rec8]* @a to <2 x i16*>)" in checks below

%rec8 = type { i16 }
@a = global [1 x %rec8] zeroinitializer

define <2 x i16*> @test_gep() {
; CHECK-LABEL: @test_gep(
; CHECK-NEXT:    ret <2 x i16*> bitcast ([1 x %rec8]* @a to <2 x i16*>)
;
  %A = getelementptr [1 x %rec8], [1 x %rec8]* @a, <2 x i16> zeroinitializer, <2 x i64> zeroinitializer
  %B = bitcast <2 x %rec8*> %A to <2 x i16*>
  ret <2 x i16*> %B
}

; Testcase that verify the cast-of-cast when the outer/second cast is to a
; vector type.

define <4 x i16> @test_mmx_const() {
; CHECK-LABEL: @test_mmx_const(
; CHECK-NEXT:    ret <4 x i16> zeroinitializer
;
  %A = bitcast <2 x i32> zeroinitializer to x86_mmx
  %B = bitcast x86_mmx %A to <4 x i16>
  ret <4 x i16> %B
}
