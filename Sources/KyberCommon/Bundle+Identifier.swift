//
//  Bundle+Identifier.swift
//  Utils
//
//  Created by Cristian Díaz (work) on 22.06.20.
//  Copyright © 2020 MeteoGroup. All rights reserved.
//

import Foundation


public extension Bundle {
  
  static var mainApp: Bundle { Bundle(identifier: "com.luisacruzmolina.Sturmfrei")! }
  
  static var dwd: Bundle { Bundle(identifier: "com.luisacruzmolina.DWD")! }
  
  static var netatmo: Bundle { Bundle(identifier: "com.luisacruzmolina.Netatmo")! }
  
}
