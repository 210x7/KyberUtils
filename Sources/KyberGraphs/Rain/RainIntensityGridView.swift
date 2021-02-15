//
//  RainRateIntensityGridView.swift
//  Sturmfrei
//
//  Created by Cristian Díaz on 27.07.20.
//


import SwiftUI

struct RainIntensityGridView: View {
  let intensities: [RainIntensityType]
  let scale: Double
  let timestamps: [Date]
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        ZStack {
          GridView(
            height: geometry.size.height,
            intensities: intensities,
            scale: scale
          )
          
          LegendView(
            height: geometry.size.height,
            intensities: intensities,
            scale: scale
          )
        }
      }
    }
  }
}

struct GridView: View {
  let height: CGFloat
  let intensities: [RainIntensityType]
  let scale: Double
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(intensities.reversed(), id: \.self) { intensity in
        Spacer()
          .frame(height: height * CGFloat(intensity.subjectiveScale / scale))
          .frame(minHeight: 0)
      }
    }
  }
}

struct LegendView: View {
  let height: CGFloat
  let intensities: [RainIntensityType]
  let scale: Double
  
  var body: some View {
    VStack {
      ForEach(intensities.reversed(), id: \.self) { intensity in
        VStack {
          HStack {
            Text(intensity.formattedAmount)
              .fontWeight(intensity.fontWeight)
            Spacer()
            Text(intensity.description)
              .fontWeight(intensity.fontWeight)
          }

          Spacer()
            .frame(minHeight: 0)
        }
        .frame(height: height * CGFloat(intensity.subjectiveScale / scale))
      }
    }
    .font(Font.system(.caption, design: .rounded))
    .minimumScaleFactor(0.7)
  }
}

struct RainRateIntensityGridView_Previews: PreviewProvider {
  static let intensities: [RainIntensityType] = [.light, .moderate, .heavy, .violent]
  static let timestamps: [Date] = [Date()]
  
  static var previews: some View {
    Group {
      RainIntensityGridView(intensities: intensities, scale: 100, timestamps: timestamps).frame(height: 200)
      RainIntensityGridView(intensities: intensities, scale: 100, timestamps: timestamps).preferredColorScheme(.dark)
    }
  }
}
