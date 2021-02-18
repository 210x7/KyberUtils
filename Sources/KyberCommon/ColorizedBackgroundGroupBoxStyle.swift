//
//  ColorizedBackgroundGroupBoxStyle.swift
//  
//
//  Created by Cristian Díaz on 16.02.21.
//

import SwiftUI

public struct ColorizedBackgroundGroupBoxStyle: GroupBoxStyle {
  public init(color: Color) {
    self.color = color
  }
  
  let color: Color
  
  public func makeBody(configuration: Configuration) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      configuration.label
      configuration.content.padding(8)
    }
    .background(
      RoundedRectangle(cornerRadius: 8).fill(color)
    )
  }
}
