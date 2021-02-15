//
//  Measurement+Average.swift
//  
//
//  Created by Cristian Díaz on 10.02.21.
//
// https://forums.swift.org/t/generic-functions-on-a-collection-of-measurements/27754/3

import Foundation

extension Collection {
  public func average <UnitType: Dimension> (in unit: UnitType) -> Measurement<UnitType>? where Element == Measurement<UnitType> {
    guard !isEmpty else { return nil }
    let sum = reduce(Measurement(value: 0, unit: unit), { $0 + $1.converted(to: unit) })
    return sum / Double(count)
  }
}
