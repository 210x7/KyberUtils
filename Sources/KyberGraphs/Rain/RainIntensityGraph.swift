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
  
  private let data: [PrecipitationData]
  private let selectedIndex: Int
  
  @Environment(\.colorScheme) private var colorScheme
  
  private var maxPrecipitation: Measurement<UnitLength>?
  private var intensities: [RainIntensityType] = []
  private var maxIntensity: RainIntensityType
  private var scale: Double
  
  public init(data: [PrecipitationData], selectedIndex: Int) {
    self.data = data
    self.selectedIndex = selectedIndex
    
    if let maxPrecipitation = data.compactMap(\.measurement).max() {
      self.maxPrecipitation = maxPrecipitation
      
      guard maxPrecipitation.value.sign == .plus else { fatalError("Invalid Negative Rain") }
      self.intensities = RainIntensityType.allCases
        .filter { $0.amount.lowerBound <= maxPrecipitation.value }
    }
    
    self.maxIntensity = intensities.last ?? .light
    self.scale = intensities.map(\.subjectiveScale).reduce(0.0, +)
  }
  
  public var body: some View {
    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
      if data.isEmpty {
        Rectangle()
          .fill(Color.clear)
          .overlay(
            Label("No data", systemImage: "xmark.shield.fill")
              .foregroundColor(.secondary)
          )
      }
      else if data.compactMap({ $0.measurement?.value }).reduce(0, +) == 0 {
        Rectangle()
          .fill(Color.clear)
          .overlay(
            Label("No rain expected", systemImage: "shield.lefthalf.fill")
              .foregroundColor(.secondary)
          )
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
            if let max = maxPrecipitation {
              Group {
                Text("max: ") + Text(max, formatter: Formatters.shared.precipitation)
              }
              .font(.caption)
              .padding(2).background(Color.controlBackground)
            }
            HStack(alignment: .bottom, spacing: 0) {
              ForEach(data, id: \.date) { data in
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
