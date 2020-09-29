//
//  RainIntensityGraph.swift
//  Sturmfrei
//
//  Created by Cristian Díaz on 06.09.20.
//

//import LightChart
import SwiftUI

public struct RainIntensityGraph: View {
  public init(values: [Measurement<UnitLength>?], selectedIndex: Int) {
    self.values = values
    self.selectedIndex = selectedIndex
  }
  
  let values: [Measurement<UnitLength>?]
  let selectedIndex: Int
  
  @Environment(\.colorScheme) var colorScheme
  
  var intensities: [RainIntensity] {
    guard
      let max = values.compactMap({ $0 }).max(),
      max.value > 0.0
    else { fatalError() }
    return RainIntensity.allCases
      .filter {
        $0.amount.lowerBound <= max.value + RainIntensity.moderate.amount.lowerBound
      }
  }
  
  var maxIntensity: RainIntensity {
    intensities.last ?? .light
  }
  
  var scale: Double {
    intensities.map(\.subjectiveScale).reduce(0.0, +)
  }
  
  public var body: some View {
    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
      if values.isEmpty {
        Label("No data", systemImage: "xmark.shield.fill")
          .foregroundColor(.secondary)
          .padding()
      }
      else if values.compactMap({ $0?.value }).reduce(0, +) == 0 {
        Label("No rain expected", systemImage: "shield.lefthalf.fill")
          .foregroundColor(.secondary)
          .padding()
      }
      else {
        ZStack {
          GeometryReader { geometry in
            ScrollView(.horizontal) {
              VStack {
                Spacer()
                HStack(alignment: .bottom, spacing: 1) {
                  ForEach(values.indices) { index in
                    
                    VStack {
                      if index == selectedIndex {
                        Image(systemName: "arrow.down")
                          .foregroundColor(.blue)
                          .font(.subheadline)
                      }
                      
                      if values.indices.contains(index),
                         let value = values[index]?.value {
                        Rectangle()
                          .fill(Color.white)
                          //.cornerRadius(25, corners: [.topLeft, .topRight])
                          .cornerRadius(25)
                          .frame(
                            width: 5,
                            height: ruleOfThree(
                              base: maxIntensity.subjectiveScale,
                              extreme: Double(geometry.size.height),
                              given: value
                            )
                          )
                      } else {
                        Rectangle().fill(Color.red).frame(height: 0)
                      }
                    }
                  }
                }
                .drawingGroup()
              }
            }
            // .background(
            //   LightChartView(
            //     data: precipitationData.map(\.value),
            //     type: .curved,
            //     visualType: .filled(color: Color(.white), lineWidth: 2)
            //   )
            //   .frame(
            //     height: ruleOfThree(
            //       base: maxIntensity.subjectiveScale,
            //       extreme: Double(geometry.size.height),
            //       given: precipitationData.max()!.value
            //     )
            //   )
            // )
            
            
            
            RainIntensityGridView(
              intensities: intensities,
              scale: scale,
              timestamps: []
            )
            
          }
        }
      }
    }
  }
}
