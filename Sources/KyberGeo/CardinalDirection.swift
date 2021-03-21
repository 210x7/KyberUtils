//
//  .swift
//  
//
//  Created by Cristian Díaz on 18.02.21.
//

import CoreLocation

//public func (for heading: CLLocationDirection) -> Int? {
//  if heading < 0 { return nil }
//
//  let directions: [Int] = [1, 2, 3, 4, 5, 6, 7, 8]
//  let index = Int((heading / 45).rounded()) % 8
//  return directions[index]
//}

public func cardinalDirection(for heading: CLLocationDirection) -> String? {
  if heading < 0 { return nil }
  
  let directions: [String] = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
  let index = Int((heading / 45).rounded()) % 8
  return directions[index]
}
