//
//  WeatherValueView.swift
//  SturmfreiCommon
//
//  Created by Cristian Díaz on 02.09.20.
//

import SwiftUI

public struct WeatherValueView<T: Unit>: View {
  public init(label: String, measurement: Measurement<T>) {
    self.label = label
    self.measurement = measurement
  }
  
  var label: String
  var measurement: Measurement<T>
  
  @ScaledMetric var size: CGFloat = 1
  
  @ViewBuilder public var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(label)
          .font(.system(size: 14 * size, weight: .semibold, design: .rounded))
          .foregroundColor(.secondary)
        Text(Formatters.shared.number.string(for: measurement.value) ?? "--")
          .font(.system(size: 24 * size, weight: .bold, design: .rounded))
          + Text(" \(measurement.unit.symbol)")
          .font(.system(size: 14 * size, weight: .semibold, design: .rounded))
          .foregroundColor(.secondary)
      }
      Spacer()
    }
  }
}
