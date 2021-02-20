//
//  File.swift
//  
//
//  Created by Cristian Díaz on 19.02.21.
//

import Foundation

public extension Array {
  
  var middle: Element? {
    guard count != 0 else { return nil }
    
    let middleIndex = (count > 1 ? count - 1 : count) / 2
    return self[middleIndex]
  }
  
}
