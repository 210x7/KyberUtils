//
//  Barometer.swift
//
//
//  Created by Cristian Díaz on 28.01.21.
//

import KyberCommon
import SwiftUI

public struct Barometer: View {
  public init(
    currentValue: Measurement<UnitPressure>,
    humidity: Int
  ) {
    self.pressure = currentValue
    self.humidity = humidity
  }

  public let pressure: Measurement<UnitPressure>
  let humidity: Int
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
        .foregroundColor(.purple)

      VStack {
        Image(systemName: "cloud.sun.fill")
          .foregroundColor(.secondary)

        GeometryReader { proxy in
          Circle()
            .trim(from: 0, to: CGFloat(sectionSize))
            .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
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
              Circle()
                .fill(Color.controlBackground)
                .colorInvert()
                .overlay(Circle().stroke(Color.controlBackground, lineWidth: 2))
                .offset(y: proxy.size.width / 2)
                .frame(width: 16)
                .rotationEffect(.degrees(getAngle(value: pressure.value)))
            )
            .overlay(
              VStack {
                Text(pressure, formatter: pressureFormatter)
                  .font(.title2.bold())
                Text("pressure")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
              .offset(y: -6)
            )
            .overlay(
              Hygrometer(currentValue: humidity)
                .frame(width: proxy.size.width / 2.1, height: proxy.size.height / 2.1)
                .offset(y: 16),
              alignment: .bottom
            )
        }
      }

      Image(systemName: "sun.max.fill")
        .foregroundColor(.yellow)
    }
    .aspectRatio(1, contentMode: .fit)
  }
}
