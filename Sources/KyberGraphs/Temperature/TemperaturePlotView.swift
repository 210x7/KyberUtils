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
  
  //TODO: check if this properties are redundant with the `DWDState` declared ones
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
  
  var differenceMinMax: Double {
    -min.value + max.value
  }
  
  var body: some View {
    GeometryReader { geometry in
      let columnWidth = geometry.size.width / CGFloat(data.count)
      ZStack {
        VStack(alignment: .leading, spacing: 0) {
          Spacer()

          //MARK: Over 0
          HStack(alignment: .bottom, spacing: 0) {
            ForEach(data, id: \.date) { data in
              if let measurement = data.measurement {
                if measurement.value > 0 {
                  Rectangle()
                    .fill(Color.pink)
                    .frame(
                      width: columnWidth,
                      height: ruleOfThree(
                        base: differenceMinMax,
                        extreme: Double(geometry.size.height),
                        given: measurement.value
                      )
                    )
                } else {
                  Rectangle().frame(width: columnWidth, height:0)
                }
                
              } else {
                Circle().frame(width: columnWidth, height: columnWidth)
              }
            }
          }
          //MARK: Below 0          
          HStack(alignment: .top, spacing: 0) {
            ForEach(data, id: \.date) { data in
              if let measurement = data.measurement {
                if measurement.value <= 0 {
                  Rectangle()
                    .fill(Color.pink).colorInvert()
                    .frame(
                      width: columnWidth,
                      height: ruleOfThree(
                        base: differenceMinMax,
                        extreme: Double(geometry.size.height),
                        given: -measurement.value
                      )
                    )
                } else {
                  Rectangle().frame(width: columnWidth, height: 0)
                }
              } else {
                Circle().frame(width: columnWidth, height: 0)
              }
            }
          }
          
        }
        .padding([.top, .bottom])
        
        VStack(alignment: .leading, spacing: 0) {
          Text("max: " + Format.temperature.string(from: max)).font(.caption)
          
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

          Text("min: " + Format.temperature.string(from: min)).font(.caption)
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
