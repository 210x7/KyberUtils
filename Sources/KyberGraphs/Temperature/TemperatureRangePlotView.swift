//
//  TemperatureRangePlotView.swift
//
//
//  Created by Cristian Díaz on 21.02.21.
//

import KyberCommon
import SwiftUI

public struct TemperatureRangePlotView: View {
  typealias GroupedTemperatureRange = (date: Date, measurements: [Measurement<UnitTemperature>])

  public init(data: [TemperatureData], selectedIndex: Int, containerSize: CGSize) {
    self.data = data
    self.selectedIndex = selectedIndex
    self.containerSize = containerSize

    let calendar = Calendar.current
    groupedDates = Dictionary(grouping: data) {
      calendar.dateComponents([.day, .month, .year], from: $0.date)
    }
    .map { (calendar.date(from: $0)!, $1.compactMap(\.measurement)) }

    guard let minTemperature = data.compactMap(\.measurement).min() else {
      fatalError("Temperature range requires minimum")
    }
    self.minTemperature = minTemperature

    guard let maxTemperature = data.compactMap(\.measurement).max() else {
      fatalError("Temperature range requires maximum")
    }
    self.maxTemperature = maxTemperature

    averageTemperature = (minTemperature + maxTemperature) / 2

    columnWidth = containerSize.width / CGFloat(groupedDates.count)
    base = {
      if minTemperature.value.sign == .plus {
        return maxTemperature.value
      } else {
        return minTemperature.value.magnitude + maxTemperature.value.magnitude
      }
    }()
  }

  let data: [TemperatureData]
  let selectedIndex: Int
  let containerSize: CGSize

  private var groupedDates: [GroupedTemperatureRange] = []

  private let minTemperature: Measurement<UnitTemperature>
  private let maxTemperature: Measurement<UnitTemperature>
  private let averageTemperature: Measurement<UnitTemperature>

  private let base: Double
  private let baseExtraPadding: Double = 3
  private let columnWidth: CGFloat

  private func offset(value: Double) -> CGFloat {
    ruleOfThree(
      base: base,
      extreme: Double(containerSize.height),
      given: value
    )
  }

  private func backgroundHeigth() -> CGFloat {
    ruleOfThree(
      base: base,
      extreme: Double(containerSize.height),
      given: {
        switch (maxTemperature.value.sign, minTemperature.value.sign) {
        case (.plus, .plus):
          return .zero

        case (.minus, .minus):
          return base

        case (.plus, .minus):
          return minTemperature.value.magnitude

        default:
          return .zero
        }
      }()
    )
  }

  public var body: some View {
    VStack(spacing: 0) {
      Rectangle().fill(Color.pink)
      Rectangle()
        .fill(Color("AlmostDowny", bundle: .module))
        .frame(height: backgroundHeigth())
    }
    .mask(
      HStack(spacing: 1) {
        ForEach(groupedDates.sorted(by: { $0.date < $1.date }), id: \.date) { data in
          let offset = offset(
            value: {
              guard
                let min = data.measurements.min()?.value,
                let max = data.measurements.max()?.value
              else { return 0 }

              return averageTemperature.value - (max.sign == .plus ? min : max)
            }()
          )

          Rectangle()
            .frame(
              width: columnWidth,
              height: ruleOfThree(
                base: base,
                extreme: Double(containerSize.height),
                given: (data.measurements.max()! - data.measurements.min()!).value
              )
            )
            .offset(y: offset)
        }
      }
      .offset(y: -offset(value: averageTemperature.value / 2))
      .frame(height: containerSize.height)
    )
  }
}
