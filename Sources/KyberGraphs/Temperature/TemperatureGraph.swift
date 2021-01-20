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
/// Dry air: 120+ °C (248+ °F) short term, 70+ °C (158+ °F) long term (with access to water at /co oler temperatures).
/// Tropical air: 60+ °C (140 °F) short term, 47 °C (117 °F) long term.
/// Saturated air: 48 °C (118 °F) short term, 35 °C (95 °F) long term.
/// Water: 46° C (115 °F) short term, 41°C (106 °F) long term.

// TODO: consolidate formatters
public let temperatureFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.unitStyle = .short
  formatter.numberFormatter.maximumFractionDigits = 0
  return formatter
}()

public struct TemperatureGraph: View {
  public init(values: [Measurement<UnitTemperature>?], selectedIndex: Int) {
    self.values = values
    self.selectedIndex = selectedIndex
  }
  
  let values: [Measurement<UnitTemperature>?]
  let selectedIndex: Int
  
  @Environment(\.colorScheme) var colorScheme
  
  public var body: some View {
    ZStack {
      if values.isEmpty {
        Label("No data", systemImage: "xmark.shield.fill")
          .foregroundColor(.secondary)
          .padding()
      }
      else {
        TemperaturePlotView(
          values: values,
          selectedIndex: selectedIndex
        )
        
        if values.indices.contains(selectedIndex),
           let measurement = values[selectedIndex] {
          Text(temperatureFormatter.string(from: measurement))
            .font(.largeTitle)
        } else {
          Text("--")
            .font(.largeTitle)
        }
        
      }
    }
    .frame(minHeight: 100)
  }
}

struct TemperaturePlotView: View {
  let values: [Measurement<UnitTemperature>?]
  let selectedIndex: Int
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView(.horizontal) {
        VStack(spacing: 0) {
          Spacer()
          
          HStack(alignment: .bottom, spacing: 1) {
            ForEach(values.indices) { index in
              
              if values.indices.contains(index),
                 let measurement = values[index] {
                
                Rectangle()
                  .fill(color(for: index))
                  .frame(
                    width: 5,
                    height: ruleOfThree(
                      base: 100, //TODO: currently only localized for metric system
                      extreme: Double(geometry.size.height),
                      given: measurement.value
                    )
                  )
              } else {
                Rectangle().fill(Color.red).frame(height: 1)
              }
            }
          }
        }
      }
    }
  }
  
  func color(for index: Int) -> Color {
    #if os(iOS)
    return (index == selectedIndex) ? Color.orange : Color(.systemBackground)
    #else
    return Color(.orange)
    #endif
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
