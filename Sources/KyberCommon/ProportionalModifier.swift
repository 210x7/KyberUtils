//
//  ProportionalFrame.swift
//
//
//  Created by Cristian Díaz on 23.02.21.
//

import SwiftUI

struct ProportionalFrame: ViewModifier {

  let height: CGFloat
  let containerHeight: CGFloat
  let maxHeight: CGFloat

  func body(content: Content) -> some View {
    content
      .frame(
        height: (height.magnitude * containerHeight) / maxHeight
      )
  }
}

extension View {
  public func proportionalFrame(
    height: CGFloat,
    containerHeight: CGFloat,
    maxHeight: CGFloat
  ) -> some View {
    self.modifier(
      ProportionalFrame(
        height: height,
        containerHeight: containerHeight,
        maxHeight: maxHeight
      )
    )
  }
}

struct ProportionalOffset: ViewModifier {

  let y: Double
  let containerHeight: CGFloat
  let maxHeight: CGFloat

  func body(content: Content) -> some View {
    content
      .offset(y: (CGFloat(y) * containerHeight) / maxHeight)
  }
}

extension View {
  public func proportionalOffset(
    y: Double,
    containerHeight: CGFloat,
    maxHeight: CGFloat
  ) -> some View {
    self.modifier(
      ProportionalOffset(
        y: y,
        containerHeight: containerHeight,
        maxHeight: maxHeight
      )
    )
  }
}

extension View {
  public func proportional(
    height: CGFloat,
    offsetY: Double = 0,
    containerHeight: CGFloat,
    maxHeight: CGFloat
  ) -> some View {
    self
      .modifier(
        ProportionalFrame(
          height: height,
          containerHeight: containerHeight,
          maxHeight: maxHeight
        )
      )
      .modifier(
        ProportionalOffset(
          y: offsetY,
          containerHeight: containerHeight,
          maxHeight: maxHeight
        )
      )
  }
}
