//
//  Styles.swift
//
//
//  Created by Cristian Díaz on 6/4/21.
//

import SwiftUI

//MARK: - SectionGroupBoxStyle

public struct SectionGroupBoxStyle: GroupBoxStyle {
  let shape = RoundedRectangle(cornerRadius: 16, style: .continuous)

  public func makeBody(configuration: Configuration) -> some View {
    VStack {
      configuration.label
      configuration.content
        .padding(8)
    }
    .background(Color.controlBackground)
    .clipShape(shape)
    .compositingGroup()
    .shadow(radius: 1)
  }
}
