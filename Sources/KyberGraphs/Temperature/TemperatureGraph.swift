//
//  TemperatureGraph.swift
//  
//
//  Created by Cristian Díaz on 10.09.20.
//

import SwiftUI
import KyberCommon

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
  
  private let calendar = Calendar.current

  //  private var groupedDates: [DateComponents : [Date]] = [:]
  private var groupedDates: [(date: Date, count: Int)] = []
  //  private var weekdaySymbols: [String] = []
  
  public init(data: [TemperatureData], selectedIndex: Int) {
    self.data = data
    self.selectedIndex = selectedIndex
    self.groupedDates = Dictionary(grouping: data.map(\.date)) {
      calendar.dateComponents([.day, .month, .year], from: $0)
    }
    .map { (calendar.date(from: $0)!, $1.count) }
  }
  
  public var body:
    some View {
    ZStack {
      if data.isEmpty {
        Label("No data", systemImage: "xmark.shield.fill")
          .foregroundColor(.secondary)
          .padding()
      }
      else {
        GeometryReader { proxy in
          TemperaturePlotView(
            data: data,
            selectedIndex: selectedIndex,
            containerSize: proxy.size
          )
          
          let columnWidth = proxy.size.width / CGFloat(data.count)
          
          HStack(alignment: .top, spacing: 0) {
            ForEach(groupedDates.sorted(by: { $0.date < $1.date }), id: \.date) {
              Text($0.date, formatter: Formatters.shared.weekday)
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(width: (columnWidth * CGFloat($0.count)) - columnWidth)
              
              Divider().frame(width: columnWidth)
            }
          }
          .padding(.leading, columnWidth)

          if let minTemperature = data.compactMap(\.measurement).min() ,
             let maxTemperature = data.compactMap(\.measurement).max() {
          
            VStack {
              Group {
                Text("max: ") + Text(maxTemperature, formatter: Formatters.shared.temperature)
              }.padding(2).background(Color.controlBackground).offset(y: -2)
              
              Spacer()
              
              Group {
                Text("min: ") + Text(minTemperature, formatter: Formatters.shared.temperature)
              }.padding(2).background(Color.controlBackground)
            }
            .font(.caption)
            
          }
        }
      }
    }
    .drawingGroup()
  }
}
