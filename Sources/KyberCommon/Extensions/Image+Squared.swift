//
//  Image+Squared.swift
//  
//
//  Created by Cristian Díaz on 18.02.21.
//

import SwiftUI

public extension Image {
  func boxed(_ alignment: Alignment = .leading) -> some View {
    Rectangle()
      .fill(Color.clear)
      .overlay(
        self
          .resizable()
          .scaledToFit(),
        alignment: alignment
      )
      .aspectRatio(contentMode: .fit)
  }
}
