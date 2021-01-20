//
//  RuleOfThree.swift
//  SturmfreiCommon
//
//  Created by Cristian Díaz on 06.09.20.
//

import Foundation
import CoreGraphics

///  a      c
/// —  =  —
///  b      x
///
/// a / b = c / x
///
/// x = b * c / a


///  a      b
/// —  =  —
///  c      x
///
/// a / c = b / x
///
/// x = c * b / a


private func f(a: Int, b: Int, c: Int) -> Int {
  (c * b) / a
}

public func ruleOfThree(base: Int, extreme: Int, given: Int) -> Int {
  f(a: base, b: extreme, c: given)
}

private func f(a: Double, b: Double, c: Double) -> Double {
  (c * b) / a
}

public func ruleOfThree(base: Double, extreme: Double, given: Double) -> Double {
  f(a: base, b: extreme, c: given)
}

private func f(a: Double, b: Double, c: Double) -> CGFloat {
  CGFloat((c * b) / a)
}

public func ruleOfThree(base: Double, extreme: Double, given: Double) -> CGFloat {
  f(a: base, b: extreme, c: given)
}


/// let a = 50.0 //mean -> base
/// let b = 120.0 //extreme
/// let c = 17.0 //mean -> given
///
/// ruleOfThree(base: a, extreme: b, given: c) // => 40.8
