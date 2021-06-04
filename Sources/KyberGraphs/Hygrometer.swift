//
//  Hygrometer.swift
//
//
//  Created by Cristian Díaz on 29.01.21.
//

import KyberCommon
import SwiftUI

public struct Hygrometer: View {
  public init(currentValue: Int) {
    self.currentValue = currentValue
  }

  public let currentValue: Int
  let sectionSize = 270 / 360.0

  func percentToRadians(percent: Int) -> Double {
    return (sectionSize * .pi / 100) * Double(percent)
  }

  public var body: some View {
    GeometryReader { geometry in
      ZStack {
        Circle()
          .trim(from: 0, to: CGFloat(sectionSize))
          .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
          .rotationEffect(.degrees(135))
          .overlay(
            Circle()
              .fill(Color.controlBackground)
              .overlay(Circle().stroke(Color.controlBackground, lineWidth: 2).colorInvert())
              .offset(y: geometry.size.width / 2)
              .frame(width: 11)
              .rotationEffect(
                .degrees(
                  percentToRadians(percent: currentValue) * 360 / .pi + 45
                )
              )
          )

        VStack {
          Text(humidityFormatter.string(for: currentValue) ?? "--")
            .font(.title3.bold())
          Text("humidity")
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
      .aspectRatio(1, contentMode: .fit)
    }
  }
}
