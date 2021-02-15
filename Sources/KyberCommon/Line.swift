//
//  Line.swift
//  
//
//  Created by Cristian Díaz on 10.02.21.
//

import SwiftUI

public struct Line: Shape {
  public init() {}
  public func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: rect.width, y: 0))
    return path
  }
}
