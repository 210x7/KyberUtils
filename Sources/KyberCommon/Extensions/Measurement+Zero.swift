//
//  Measurement+Zero.swift
//  Sturmfrei
//
//  Created by Cristian Díaz on 01.02.19.
//

import Foundation

public extension Measurement where UnitType == UnitTemperature {
  /// ...the use of a sign bit causes positive and negative zero values to exist.
  /// This is the case for IEEE 754 floating-point numbers.
  ///
  /// Swift built-in floating-point types implement equality in such a
  /// way that doesn’t distinguish between the two varieties of zero.
  /// This equality check is equivalent to calling the isZero property.
  ///
  /// -0.0 == 0.0 // true
  /// 0.0.isZero // true
  /// -0.0.isZero // true
  ///
  /// Excerpt From: Mattt Zmuda. “Flight School - Guide to Swift Numbers”
  func forcingPositiveZero() -> Measurement<UnitTemperature> {
    if Double(round(self.value)).isZero {
      return Measurement<UnitTemperature>(value: 0, unit: self.unit)
    }
    
    return self
  }
}
