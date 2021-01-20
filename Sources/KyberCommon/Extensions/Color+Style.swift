//
//  Color+Style.swift
//  SturmfreiCommon
//
//  Created by Cristian Díaz on 01.10.20.
//

import SwiftUI

extension Color {
  public static var controlBackground: Color {
    #if os(macOS)
    return Color(.controlBackgroundColor)
    #else
    return Color(.systemBackground)
    #endif
  }
  
  public static var moduleSelection: Color {
    #if os(macOS)
    return Color(.selectedControlColor)
    #else
    return .accentColor
    #endif
  }
}
