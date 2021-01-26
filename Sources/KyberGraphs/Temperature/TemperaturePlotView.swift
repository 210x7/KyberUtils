//
//  TemperaturePlotView.swift
//  
//
//  Created by Cristian Díaz on 26.01.21.
//

import SwiftUI
import KyberCommon

struct TemperaturePlotView: View {
  let data: [TemperatureData]
  let selectedIndex: Int
  
  var min: Measurement<UnitTemperature> {
    guard let min = data.compactMap({ $0.measurement }).min() else {
      return Measurement<UnitTemperature>(value: 0, unit: .celsius)
    }
    return min
  }
  
  var max: Measurement<UnitTemperature> {
    guard
      let max = data.compactMap({ $0.measurement }).max(),
      max.value > 0 else {
      return Measurement<UnitTemperature>(value: 1, unit: .celsius)
    }
    return max
  }
  
  
  var body: some View {
    GeometryReader { geometry in
      
      let columnWidth = geometry.size.width / CGFloat(data.count)
      ZStack {
        VStack(spacing: 0) {
          Text("max: " + temperatureFormatter.string(from: max))
          // Divider()
          HStack(spacing: 0) {
            ForEach(data, id: \.date) { data in
              let components = Calendar.current.dateComponents([.hour], from: (data.date))
              if components.hour == 0 {
                Divider().frame(width: columnWidth)
              }
              else {
                Divider().frame(width: columnWidth, height: 0)
              }
            }
          }
          .frame(height: geometry.size.height)
          // Divider()
          Text("min: " + temperatureFormatter.string(from: min))
        }
        
        VStack(alignment: .leading, spacing: 0) {
          
          //MARK: Over 0
          
          HStack(alignment: .bottom, spacing: 0) {
            ForEach(data.indices) { index in
              if data.indices.contains(index), let measurement = data[index].measurement {
                if measurement.value > 0 {
                  Rectangle()
                    .fill(color(for: index))
                    .frame(
                      width: columnWidth,
                      height: CGFloat(measurement.value / max.value) * geometry.size.height/2
                    )
                } else {
                  Rectangle().frame(width: columnWidth, height:0)
                }
                
              } else {
                Circle().fill(Color.red).frame(width: columnWidth, height: 5)
              }
            }
          }
          
          //MARK: Below 0
          
          HStack(alignment: .top, spacing: 0) {
            ForEach(data.indices) { index in
              if data.indices.contains(index), let measurement = data[index].measurement {
                if measurement.value <= 0 {
                  Rectangle()
                    .fill(color(for: index)).colorInvert()
                    .frame(
                      width: columnWidth,
                      height: -CGFloat(measurement.value / -min.value) * geometry.size.height/2
                    )
                } else {
                  Rectangle().frame(width: columnWidth, height: 0)
                }
              } else {
                Circle().fill(Color.red).frame(width: columnWidth, height: 5)
              }
            }
          }
          
        }
      }
      .drawingGroup()
      .frame(height: geometry.size.height)
    }
  }
  
  func color(for index: Int) -> Color {
    #if os(iOS)
    return (index == selectedIndex) ? Color.orange : Color(.systemBackground)
    #else
    return Color(.systemPink)
    #endif
  }
}
