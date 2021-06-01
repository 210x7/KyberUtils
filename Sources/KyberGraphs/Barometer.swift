//
//  Barometer.swift
//
//
//  Created by Cristian Díaz on 28.01.21.
//

import SwiftUI

public struct Barometer: View {
  public init(
    currentValue: Double,
    humidity: Int
  ) {
    self.currentValue = currentValue
    self.humidity = humidity
  }

  public let currentValue: Double
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
        .foregroundColor(Color(.tertiaryLabelColor))

      VStack {
        Image(systemName: "cloud.sun.fill")
          .foregroundColor(Color(.tertiaryLabelColor))
        //.padding(.bottom, 4)

        GeometryReader { proxy in
          // ZStack {
          Circle()
            .trim(from: 0, to: CGFloat(sectionSize))
            .stroke(style: StrokeStyle(lineWidth: 9, lineCap: .round))
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
                .offset(y: proxy.size.width / 2)
                .frame(width: 11, height: 7)
                .rotationEffect(.degrees(getAngle(value: currentValue)))
            )
            .overlay(
              ZStack {
                // Text("\(minValue)")
                //   .rotationEffect(.degrees(getAngle(value: 4)))
                //   .offset(y: proxy.size.width / 2 + 8)
                //   .font(.caption)
                //   .foregroundColor(.secondary)
                //   .rotationEffect(.degrees(getAngle(value: 30)))
                //
                // Text("\(maxValue)")
                //   .rotationEffect(.degrees(getAngle(value: 30)))
                //   .offset(y: proxy.size.width / 2 + 8)
                //   .font(.caption)
                //   .foregroundColor(.secondary)
                //   .rotationEffect(.degrees(getAngle(value: 270)))

                VStack {
                  Text("\(Int(currentValue))").font(.headline)
                  Text("hPa").font(.subheadline).foregroundColor(.secondary)
                }
                .offset(y: -10)
              }
            )
            .overlay(
              Hygrometer(currentValue: humidity)
                .frame(width: proxy.size.width / 2.2, height: proxy.size.height / 2.2)
                .offset(y: 6),
              alignment: .bottom
            )

          // }
          // .aspectRatio(1, contentMode: .fit)
        }
      }

      Image(systemName: "sun.max.fill")
        .foregroundColor(Color(.tertiaryLabelColor))
    }
    .aspectRatio(1, contentMode: .fit)
  }
}
