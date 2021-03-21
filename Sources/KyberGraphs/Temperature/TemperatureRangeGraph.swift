//
//  TemperatureRangeGraph.swift
//
//
//  Created by Cristian Díaz on 21.02.21.
//

import KyberCommon
import SwiftUI

public struct TemperatureRangeGraph: View {
  let data: [TemperatureData]
  let selectedIndex: Int
  var filledStyle = false

  private let calendar = Calendar.current
  private var groupedDates: [(date: Date, count: Int)] = []

  public init(data: [TemperatureData], selectedIndex: Int, filledStyle: Bool = false) {
    self.data = data
    self.selectedIndex = selectedIndex
    self.filledStyle = filledStyle
    self.groupedDates = Dictionary(grouping: data.map(\.date)) {
      calendar.dateComponents([.day, .month, .year], from: $0)
    }
    .map { (calendar.date(from: $0)!, $1.count) }
  }

  public var body: some View {
    GeometryReader { proxy in
      ZStack(alignment: .leading) {
        if data.isEmpty {
          Label("No data", systemImage: "xmark.shield.fill")
            .foregroundColor(.secondary)
            .padding()
        } else {
          if filledStyle {
            TemperatureRangePlotViewFilled(
              data: data,
              selectedIndex: selectedIndex
            )
          } else {
            TemperatureRangePlotView(
              data: data,
              selectedIndex: selectedIndex,
              containerSize: proxy.size
            )

          }

          let columnWidth = proxy.size.width / CGFloat(groupedDates.count)

          HStack(alignment: .top, spacing: 0) {
            ForEach(groupedDates.sorted(by: <), id: \.date) {
              Text($0.date, formatter: Formatters.shared.weekday)
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(width: columnWidth)

              Divider()
            }
          }
          .offset(x: -7)

          if let minTemperature = data.compactMap(\.measurement).min(),
            let maxTemperature = data.compactMap(\.measurement).max()
          {
            VStack(alignment: .leading) {
              Group {
                Text("max: ") + Text(maxTemperature, formatter: Formatters.shared.temperature)
              }.background(Color.controlBackground).offset(y: -2)

              Spacer()

              Group {
                let average: Measurement<UnitTemperature> = ((minTemperature + maxTemperature) / 2)
                Text("avg: ") + Text(average, formatter: Formatters.shared.temperature)
              }.background(Color.controlBackground)

              Spacer()

              Group {
                Text("min: ") + Text(minTemperature, formatter: Formatters.shared.temperature)
              }.background(Color.controlBackground)
            }
            .font(.caption)
//            .padding(2)
          }

        }
      }
    }
    // .drawingGroup() //Creates problems with masks used in the `PlotView`
  }
}
