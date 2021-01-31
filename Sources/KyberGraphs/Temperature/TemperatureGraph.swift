//
//  TemperatureGraph.swift
//  
//
//  Created by Cristian Díaz on 10.09.20.
//

import SwiftUI

/// https://www.quora.com/What-is-the-highest-temperature-a-human-being-can-survive
///
/// TL:DR numbers:
/// Dry air: 120+ °C (248+ °F) short term, 70+ °C (158+ °F) long term (with access to water at /cooler temperatures).
/// Tropical air: 60+ °C (140 °F) short term, 47 °C (117 °F) long term.
/// Saturated air: 48 °C (118 °F) short term, 35 °C (95 °F) long term.
/// Water: 46° C (115 °F) short term, 41°C (106 °F) long term.

public typealias TemperatureData = (date: Date, measurement: Measurement<UnitTemperature>?)

public struct TemperatureGraph: View {
  public init(data: [TemperatureData], selectedIndex: Int) {
    self.data = data
    self.selectedIndex = selectedIndex
  }
  
  let data: [TemperatureData]
  let selectedIndex: Int
  
  @Environment(\.colorScheme) var colorScheme
  
  public var body: some View {
    ZStack {
      if data.isEmpty {
        Label("No data", systemImage: "xmark.shield.fill")
          .foregroundColor(.secondary)
          .padding()
      }
      else {
        TemperaturePlotView(
          data: data,
          selectedIndex: selectedIndex
        )
        
        //        if values.indices.contains(selectedIndex),
        //           let measurement = values[selectedIndex] {
        //          Text(temperatureFormatter.string(from: measurement))
        //            .font(.largeTitle)
        //        } else {
        //          Text("--")
        //            .font(.largeTitle)
        //        }
        
      }
    }.padding([.top, .bottom])
    
  }
}

// VStack {
//   if values.indices.contains(index),
//      let measurement = values[index] {
//
//     if index == selectedIndex {
//       VStack {
//         Text(temperatureFormatter.string(from: measurement)).frame(width: 100)
//         Image(systemName: "arrow.down")
//           .foregroundColor(.blue)
//           .font(.subheadline)
//       }
//     }
//     Rectangle()
//       .foregroundColor(.clear)
//       .frame(
//         height: ruleOfThree(
//           base: 100,
//           extreme: Double(geometry.size.height),
//           given: measurement.value
//         )
//       )
//   } else {
//     Rectangle().fill(Color.red).frame(height: 1)
//   }
// }




//                Rectangle()
//                  .fill(color(for: index))
//                  .frame(
//                    width: 5,
//                    height: ruleOfThree(
//                      base: 100, //TODO: currently only localized for metric system
//                      extreme: Double(geometry.size.height),
//                      given: measurement.value
//                    )
//                  )
