//
//  RadarChartGrid.swift
//  
//
//  Created by Cristian Díaz on 27.01.21.
//

import SwiftUI

struct RadarChartGrid: Shape {
  let categories: Int
  let divisions: Int
  
  func path(in rect: CGRect) -> Path {
    let radius = min(rect.maxX - rect.midX, rect.maxY - rect.midY)
    let stride = radius / CGFloat(divisions)
    var path = Path()
    
    for category in 1 ... categories {
      path.move(to: CGPoint(x: rect.midX, y: rect.midY))
      path.addLine(to: CGPoint(x: rect.midX + cos(CGFloat(category) * 2 * .pi / CGFloat(categories) - .pi / 2) * radius,
                               y: rect.midY + sin(CGFloat(category) * 2 * .pi / CGFloat(categories) - .pi / 2) * radius))
    }
    
    for step in 1 ... divisions {
      let rad = CGFloat(step) * stride
      path.move(to: CGPoint(x: rect.midX + cos(-.pi / 2) * rad,
                            y: rect.midY + sin(-.pi / 2) * rad))
      
      for category in 1 ... categories {
        path.addLine(to: CGPoint(x: rect.midX + cos(CGFloat(category) * 2 * .pi / CGFloat(categories) - .pi / 2) * rad,
                                 y: rect.midY + sin(CGFloat(category) * 2 * .pi / CGFloat(categories) - .pi / 2) * rad))
      }
    }
    
    return path
  }
}
