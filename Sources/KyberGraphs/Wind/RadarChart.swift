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
        Spacer()
        Text("W")
        ZStack {
          RadarChartGrid(categories: data.count, divisions: 10)
            .stroke(gridColor, lineWidth: 0.5)

          RadarChartPath(data: data)
            .fill(dataColor.opacity(0.3))

          RadarChartPath(data: data)
            .stroke(dataColor, lineWidth: 1.0)
        }
        
        Text("E")
      }
      Text("S")
      Spacer()
    }
    .font(.caption)
    .drawingGroup()
  }
}
