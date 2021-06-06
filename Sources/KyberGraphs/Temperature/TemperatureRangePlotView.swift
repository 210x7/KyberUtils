//
//  TemperatureRangePlotView.swift
//
//
//  Created by Cristian Díaz on 21.02.21.
//

import KyberCommon
import SwiftUI
import SwiftUICharts

public struct TemperatureRangePlotView: View {
  typealias GroupedTemperatureRange = (date: Date, measurements: [Measurement<UnitTemperature>])

  private var groupedDates: [GroupedTemperatureRange] = []
  private let chartData: RangedBarChartData

  public init(data: [TemperatureData], selectedIndex: Int, containerSize: CGSize) {
    let calendar = Calendar.current
    self.groupedDates = Dictionary(grouping: data) {
      calendar.dateComponents([.day, .month, .year], from: $0.date)
    }
    .map { (calendar.date(from: $0)!, $1.compactMap(\.measurement)) }

    let dataSet: RangedBarDataSet = .init(
      dataPoints: groupedDates.sorted(by: { $0.date < $1.date }).map {
        return RangedBarDataPoint(
          lowerValue: $0.measurements.min()!.value,
          upperValue: $0.measurements.max()!.value,
          xAxisLabel: weekdayFormatter.string(from: $0.date)
        )
      }
    )

    let barStyle: BarStyle = .init(
      barWidth: 1,
      cornerRadius: .init(top: 0, bottom: 0),
      colourFrom: .barStyle,
      colour: .init(colour: .red)
    )

    let gridStyle = GridStyle(
      numberOfLines: groupedDates.count + 1,
      lineColour: Color(.gridColor),
      lineWidth: 1,
      dash: [1, 0]
    )

    let chartStyle = BarChartStyle(
      infoBoxPlacement: .header,
      infoBoxContentAlignment: .horizontal,
      xAxisGridStyle: gridStyle,
      xAxisLabelPosition: .top,
      yAxisLabelPosition: .trailing,
      yAxisNumberOfLabels: 3,
      globalAnimation: .linear(duration: 0)
    )

    self.chartData = RangedBarChartData(
      dataSets: dataSet,
      barStyle: barStyle,
      chartStyle: chartStyle
    )

    ///Requires to be modified ater construction to retrieve correct values for `RangedBarChartData`
    self.chartData.metadata = .init(
      title: temperatureFormatter.string(
        from: Measurement<UnitTemperature>(
          value: chartData.average,
          unit: .celsius)
      ),
      subtitle: "average"
    )

    self.chartData.chartStyle.baseline = (chartData.minValue >= 0) ? .zero : .minimumValue
  }

  public var body: some View {
    VStack {
      RangedBarChart(chartData: chartData)
        .touchOverlay(chartData: chartData, specifier: "%.1f", unit: .suffix(of: "ºC"))
        //.linearTrendLine(
        //  chartData: data,
        //  firstValue: data.dataSets.dataPoints.first!.average,
        //  lastValue: data.dataSets.dataPoints.last!.average
        //)
        .averageLine(
          chartData: chartData,
          labelPosition: .none,
          strokeStyle: StrokeStyle(lineWidth: 0.5)
        )
        .xAxisGrid(chartData: chartData)
        .xAxisLabels(chartData: chartData)
        .yAxisLabels(chartData: chartData)
        .headerBox(chartData: chartData)
        //.infoBox(chartData: data)
        .id(chartData.id)
    }
  }
}

extension RangedBarDataPoint {
  fileprivate var average: Double {
    (self.lowerValue + self.upperValue) / 2
  }
}
