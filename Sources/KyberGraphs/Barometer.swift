//
//  Barometer.swift
//  
//
//  Created by Cristian Díaz on 28.01.21.
//

import SwiftUI

public struct Barometer: View {
  public init(currentValue: Double) {
    self.currentValue = currentValue
  }
  
  public let currentValue: Double
  let minValue: Int = 950
  let maxValue: Int = 1050
  let sectionSize = 270 / 360.0
  
  
  func getPercentage(value: Double) -> Double {
    (value - Double(minValue)) / Double(maxValue - minValue)
  }
  
  func getAngle(value: Double) -> Double {
    return getPercentage(value: value) * 270
  }
  
  let colors: [Color] = [.purple, .purple, .secondary, .yellow, .yellow]
  
  public var body: some View {
    HStack {
      Image(systemName: "cloud.rain.fill")
        .foregroundColor(Color(.tertiaryLabelColor))
      
      VStack {
        Image(systemName: "cloud.sun.fill")
          .foregroundColor(Color(.tertiaryLabelColor))
          .padding(.bottom, 4)
        
        GeometryReader { geometry in
          ZStack {
            Circle()
              .trim(from: 0, to: CGFloat(sectionSize))
              .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round))
              .fill(
                AngularGradient(
                  gradient: Gradient(colors: colors),
                  center: UnitPoint(x: 0.50, y: 0.50),
                  startAngle: Angle(degrees: 0),
                  endAngle: Angle(degrees: 270)
                )
              )
              .rotationEffect(.degrees(135))
              .overlay(
                Capsule()
                  .fill(Color.controlBackground)
                  .offset(y: geometry.size.width / 2)
                  .frame(width: 11, height: 5)
                  .rotationEffect(.degrees(getAngle(value: currentValue)))
              )
            
            // Text("\(minValue)")
            //   .rotationEffect(.degrees(getAngle(value: 4)))
            //   .offset(y: geometry.size.width/2 + 8)
            //   .font(.caption)
            //   .foregroundColor(.secondary)
            //   .rotationEffect(.degrees(getAngle(value: 30)))
            //
            // Text("\(maxValue)")
            //   .rotationEffect(.degrees(getAngle(value: 30)))
            //   .offset(y: geometry.size.width/2 + 8)
            //   .font(.caption)
            //   .foregroundColor(.secondary)
            //   .rotationEffect(.degrees(getAngle(value: 270)))
            
            VStack {
              Text("\(Int(currentValue))").font(.title2).bold()
              Text("hPa").font(.subheadline).bold().foregroundColor(.secondary)
            }
          }
          .aspectRatio(1, contentMode: .fit)
        }
      }
      
      Image(systemName: "sun.max.fill")
        .foregroundColor(Color(.tertiaryLabelColor))
    }
    .aspectRatio(1, contentMode: .fit)
  }
}
