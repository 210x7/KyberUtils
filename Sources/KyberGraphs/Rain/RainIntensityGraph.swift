//
//  RainIntensityGraph.swift
//  Sturmfrei
//
//  Created by Cristian Díaz on 06.09.20.
//

import KyberCommon
import SwiftUI
import SwiftUICharts

public typealias PrecipitationData = (date: Date, measurement: Measurement<UnitLength>?)

public struct RainIntensityGraph: View {
  private var chartData: BarChartData

  public init(data: [PrecipitationData], selectedIndex: Int, useSpacing: Bool = false) {
    let dataSet: BarDataSet = .init(
      dataPoints: data.compactMap {
        guard let value = $0.measurement?.value else { return nil }
        return BarChartDataPoint(
          value: value,
          date: $0.date
        )
      }
    )

    let barStyle: BarStyle = .init(
      barWidth: 0.8,
      cornerRadius: .init(top: 0, bottom: 0),
      colourFrom: .barStyle,
      colour: .init(colour: .purple)
    )

    let gridStyle = GridStyle(
      numberOfLines: data.count + 1,
      lineColour: Color(.gridColor),
      lineWidth: 1,
      dash: [1, 0]
    )

    let chartStyle: BarChartStyle = .init(
      infoBoxPlacement: .header,  //.infoBox(isStatic: true),
      infoBoxContentAlignment: .horizontal,
      markerType: .vertical(),
      xAxisGridStyle: gridStyle,
      yAxisLabelPosition: .trailing,
      yAxisNumberOfLabels: 3,
      baseline: .zero,
      topLine: .maximum(
        of:
          RainIntensityType
          .caseFor(amount: dataSet.maxValue())
          .subjectiveScale
      ),
      globalAnimation: .linear(duration: 0)
    )

    self.chartData = BarChartData(
      dataSets: dataSet,
      metadata: .init(
        title: precipitationFormatter2.string(
          from: Measurement<UnitLength>(value: dataSet.average(), unit: .millimeters)),
        subtitle: "average"
      ),
      barStyle: barStyle,
      chartStyle: chartStyle,
      noDataText: Text("NO DATA")
    )
  }

  public var body: some View {
    VStack {
      BarChart(chartData: self.chartData)
        .touchOverlay(chartData: self.chartData, specifier: "%.1f", unit: .suffix(of: "mm"))
        .averageLine(
          chartData: chartData,
          labelPosition: .none,
          strokeStyle: StrokeStyle(lineWidth: 0.5)
        )
        //.xAxisGrid(chartData: self.chartData)
        .xAxisLabels(chartData: self.chartData)
        .yAxisLabels(chartData: self.chartData)
        .headerBox(chartData: chartData)
        // .infoBox(chartData: data, height: 22)
        .id(chartData.id)
    }
  }
}

/*
public struct RainIntensityGraph: View {
  public init(data: [PrecipitationData], selectedIndex: Int, useSpacing: Bool = false) {
    self.data = data
    self.selectedIndex = selectedIndex
    self.useSpacing = useSpacing

    if let maxPrecipitation = data.compactMap(\.measurement).max() {
      self.maxPrecipitation = maxPrecipitation

      guard maxPrecipitation.value.sign == .plus else { fatalError("Invalid Negative Rain") }
      self.intensities = RainIntensityType.allCases
        .filter { $0.amount.lowerBound <= maxPrecipitation.value }
    }

    self.maxIntensity = intensities.last ?? .light
    self.scale = intensities.map(\.subjectiveScale).reduce(0.0, +)
    self.groupedDates = Dictionary(grouping: data.map(\.date)) {
      calendar.dateComponents([.day, .month, .year], from: $0)
    }
    .map { (calendar.date(from: $0)!, $1.count) }
  }

  let data: [PrecipitationData]
  let selectedIndex: Int

  private let calendar = Calendar.current
  private var groupedDates: [(date: Date, count: Int)] = []

  @Environment(\.colorScheme) private var colorScheme

  var maxPrecipitation: Measurement<UnitLength>?
  var intensities: [RainIntensityType] = []
  let maxIntensity: RainIntensityType
  let scale: Double
  let useSpacing: Bool

  public var body: some View {
    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
      if data.isEmpty {
        Rectangle()
          .fill(Color.clear)
          .overlay(
            Label("No data", systemImage: "xmark.shield.fill")
              .foregroundColor(.secondary)
          )
      } else if data.compactMap({ $0.measurement?.value }).reduce(0, +) == 0 {
        Rectangle()
          .fill(Color.clear)
          .overlay(
            Label("No rain expected", systemImage: "shield.lefthalf.fill")
              .foregroundColor(.secondary)
          )
      } else {
        GeometryReader { geometry in

          let columnWidth = geometry.size.width / CGFloat(groupedDates.count)
          //FIXME: when granularity is hourly, `useSpacing` makes no sense
          if !useSpacing {
            HStack(spacing: 0) {
              ForEach(groupedDates.sorted(by: { $0.date < $1.date }), id: \.date) { data in
                let components = Calendar.current.dateComponents([.hour], from: (data.date))
                if components.hour == 0 {
                  Divider().frame(width: columnWidth)
                } else {
                  Divider().frame(width: columnWidth, height: 0)
                }
              }
            }
            .padding(.leading, columnWidth / 2)
          }

          VStack {
            Spacer()
            if let max = maxPrecipitation {
              Group {
                Text("max: ") + Text(max, formatter: precipitationFormatter)
              }
              .font(.caption)
              .padding(2).background(Color.controlBackground)
            }

            HStack(alignment: .bottom, spacing: useSpacing ? 0.5 : 0) {
              ForEach(data, id: \.date) { data in
                if let measurement = data.measurement {
                  Rectangle()
                    .fill(Color.purple)
                    .frame(
                      height: ruleOfThree(
                        base: maxIntensity.subjectiveScale,
                        extreme: Double(geometry.size.height),
                        given: measurement.value
                      )
                    )
                } else {
                  Circle()
                    .fill(Color.red)
                    .frame(
                      width: columnWidth,
                      height: 0
                    )
                }
              }
            }
          }

          RainIntensityGridView(
            intensities: intensities,
            scale: scale,
            timestamps: []
          )

        }
        .drawingGroup()
      }
    }
  }
}
*/
