//
//  View+Measured.swift
//
//
//  Created by Cristian Díaz on 23.02.21.
//

import SwiftUI

extension View {
  public func measured(_ color: Color) -> some View {
    overlay(
      GeometryReader { p in
        VStack(spacing: 0) {
          Arrow()
          Text("\(p.size.height, specifier: "%.0f")")
            .font(.caption)
            .foregroundColor(color)
            .fixedSize()
          Arrow()
            .scaleEffect(-1, anchor: .center)
        }
      })
  }

  public var measured: some View {
    measured(.white)
  }
}

struct ArrowShape: Shape {
  func path(in rect: CGRect) -> Path {
    Path { p in
      let x = rect.midX
      let size: CGFloat = 5
      p.move(to: CGPoint(x: x, y: rect.minY))
      p.addLine(to: CGPoint(x: x + size, y: rect.minY + size))
      p.move(to: CGPoint(x: x, y: rect.minY))
      p.addLine(to: CGPoint(x: x - size, y: rect.minY + size))
      p.move(to: CGPoint(x: x, y: rect.minY))
      p.addLine(to: CGPoint(x: x, y: rect.maxY))
    }
  }
}

struct Arrow: View {
  var body: some View {
    ArrowShape()
      .stroke(lineWidth: 1)
      .foregroundColor(Color(red: 9 / 255.0, green: 73 / 255.0, blue: 109 / 255.0))
  }
}
