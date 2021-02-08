//
//  RadarChart.swift
//  
//
//  Created by Cristian Díaz on 27.01.21.
//

import SwiftUI

public struct RadarChart: View {
  var data: [Double]
  let gridColor: Color
  let dataColor: Color
  
  public init(data: [Double], gridColor: Color = .gray, dataColor: Color = .blue) {
    self.data = data
    self.gridColor = gridColor
    self.dataColor = dataColor
  }
  
  public var body: some View {
    VStack {
      Text("N")
      HStack {
        Text("W")
        ZStack {
          RadarChartGrid(categories: data.count, divisions: 10)
            .stroke(gridColor, lineWidth: 0.5)
          
          RadarChartPath(data: data)
            .fill(dataColor.opacity(0.3))
          
          RadarChartPath(data: data)
            .stroke(dataColor, lineWidth: 2.0)
        }
        .scaledToFill()
        Text("E")
      }
      Text("S")
    }
    .font(.caption)
    .drawingGroup()
  }
}

public func compassDirection(for heading: CLLocationDirection) -> Int? {
  if heading < 0 { return nil }
  
  let directions: [Int] = [1, 2, 3, 4, 5, 6, 7, 8]
  let index = Int((heading / 45).rounded()) % 8
  return directions[index]
}

public func compassDirectionDescription(for heading: CLLocationDirection) -> String? {
  if heading < 0 { return nil }
  
  let directions: [String] = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
  let index = Int((heading / 45).rounded()) % 8
  return directions[index]
}
