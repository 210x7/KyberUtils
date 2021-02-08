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
  let data: [TemperatureData]
  let selectedIndex: Int

  public init(data: [TemperatureData], selectedIndex: Int) {
    self.data = data
    self.selectedIndex = selectedIndex
  }
    
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
      }
    }
    .padding([.top, .bottom])
    .drawingGroup()
  }
}
