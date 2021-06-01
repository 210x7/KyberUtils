//
//  Hygrometer.swift
//
//
//  Created by Cristian Díaz on 29.01.21.
//

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
          .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
          //.foregroundColor(Color.yellow)
          .rotationEffect(.degrees(135))
          .overlay(
            Capsule()
              .fill(Color.controlBackground)
              .offset(y: geometry.size.width / 2)
              .frame(width: 7, height: 3)
              .rotationEffect(
                .degrees(
                  percentToRadians(percent: currentValue) * 360 / .pi + 45
                )
              )
          )
        
        VStack(spacing: 0) {
          Text("\(currentValue)").font(.headline)
          Text("%").font(.subheadline).foregroundColor(.secondary)
        }
        .padding(.top, 10)
      }
    }
    .aspectRatio(1, contentMode: .fit)
  }
}
