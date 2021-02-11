//
//  RainIntensityGraph.swift
//  Sturmfrei
//
//  Created by Cristian Díaz on 06.09.20.
//

import SwiftUI
import KyberCommon

public typealias PrecipitationData = (date: Date, measurement: Measurement<UnitLength>?)


public struct RainIntensityGraph: View {
  public init(data: [PrecipitationData], selectedIndex: Int) {
    self.data = data
    self.selectedIndex = selectedIndex
  }
  
  let data: [PrecipitationData]
  let selectedIndex: Int
  
  @Environment(\.colorScheme) var colorScheme
  
  var maxMeasurement: Measurement<UnitLength> {
    data.compactMap(\.measurement).max() ?? .init(value: 0, unit: .millimeters)
  }
  
  var intensities: [RainIntensityType] {
    guard maxMeasurement.value > 0.0 else { fatalError() }
    return RainIntensityType.allCases
      .filter {
        $0.amount.lowerBound <= maxMeasurement.value
      }
  }
  
  var maxIntensity: RainIntensityType {
    intensities.last ?? .light
  }
  
  var scale: Double {
    intensities.map(\.subjectiveScale).reduce(0.0, +)
  }
  
  public var body: some View {
    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
      if data.isEmpty {
        Label("No data", systemImage: "xmark.shield.fill")
          .fixedSize()
          .foregroundColor(.secondary)
          .padding()
        
      }
      else if data.compactMap({ $0.measurement?.value }).reduce(0, +) == 0 {
        Label("No rain expected", systemImage: "shield.lefthalf.fill")
          .fixedSize()
          .foregroundColor(.secondary)
          .padding()
      }
      else {
        GeometryReader { geometry in
          let columnWidth = geometry.size.width / CGFloat(data.count)
          
          HStack(spacing: 0) {
            ForEach(data, id: \.date) { data in
              let components = Calendar.current.dateComponents([.hour], from: (data.date))
              if components.hour == 0 {
                Divider().frame(width: columnWidth)
              }
              else {
                Divider().frame(width: columnWidth, height: 0)
              }
            }
          }
          .frame(height: geometry.size.height)
          
          VStack {
            Spacer()
            Group {
              Text("max: ") + Text(maxMeasurement, formatter: Format.precipitation)
            }.font(.caption)
            HStack(alignment: .bottom, spacing: 0) {
              ForEach(data, id: \.date) { data in
                // VStack {
                
                // if index == selectedIndex {
                //   Image(systemName: "arrow.down")
                //     .foregroundColor(.secondary)
                // }
                
                if let measurement = data.measurement {
                  Rectangle()
                    .fill(Color.purple)
                    .frame(
                      width: columnWidth,
                      height: ruleOfThree(
                        base: maxIntensity.subjectiveScale,
                        extreme: Double(geometry.size.height),
                        given: measurement.value
                      )
                    )
                }
                else {
                  Circle()
                    .fill(Color.red)
                    .frame(
                      width: columnWidth,
                      height: 0
                    )
                }
                
                // }
              }
            }
          }
          
          RainIntensityGridView(
            intensities: intensities,
            scale: scale,
            timestamps: []
          )
          
        }.drawingGroup()
      }
    }
  }
}
