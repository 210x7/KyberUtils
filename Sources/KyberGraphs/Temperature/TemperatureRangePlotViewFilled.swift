//
//  TemperatureRangePlotViewFilled.swift
//
//
//  Created by Cristian Díaz on 21.02.21.
//

import KyberCommon
import SwiftUI

public struct TemperatureRangePlotViewFilled: View {
  typealias GroupedTemperatureRange = (date: Date, measurements: [Measurement<UnitTemperature>])

  public init(data: [TemperatureData], selectedIndex: Int) {
    self.data = data
    self.selectedIndex = selectedIndex

    let calendar = Calendar.current
    groupedDates = Dictionary(grouping: data) {
      calendar.dateComponents([.day, .month, .year], from: $0.date)
    }
    .map { (calendar.date(from: $0)!, $1.compactMap(\.measurement)) }

    guard let minTemperature = data.compactMap(\.measurement).min() else {
      fatalError("Temperature range requires minimum")
    }
    guard let maxTemperature = data.compactMap(\.measurement).max() else {
      fatalError("Temperature range requires maximum")
    }

    self.minTemperature = minTemperature
    self.maxTemperature = maxTemperature
    self.averageTemperature = (minTemperature + maxTemperature) / 2

    self.base = maxTemperature.value - minTemperature.value
  }

  let data: [TemperatureData]
  let selectedIndex: Int

  private let groupedDates: [GroupedTemperatureRange]

  private let minTemperature: Measurement<UnitTemperature>
  private let maxTemperature: Measurement<UnitTemperature>
  private let averageTemperature: Measurement<UnitTemperature>

  private let base: Double

  public var body: some View {
    GeometryReader { proxy in

      let containerHeight = proxy.size.height
      let maxHeight = CGFloat(base)

      VStack(spacing: 0) {
        Rectangle().fill(Color.pink)
        Rectangle().fill(Color.pink).colorInvert()
          .proportionalFrame(
            height: CGFloat(min(0, minTemperature.value)),
            containerHeight: containerHeight,
            maxHeight: maxHeight
          )
      }
      .mask(
        HStack(spacing: 1) {
          ForEach(groupedDates.sorted(by: { $0.date < $1.date }), id: \.date) { data in
            CandleStack(
              values: data.measurements.min()!.value...data.measurements.max()!.value,
              extremes: minTemperature.value...maxTemperature.value,
              containerHeight: containerHeight,
              maxHeight: maxHeight
            )
          }
        }
      )
    }
  }
}
