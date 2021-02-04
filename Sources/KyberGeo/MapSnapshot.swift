//
//  MapSnapshot.swift
//  
//
//  Created by Cristian Díaz on 26.01.21.
//

import SwiftUI
import ComposableArchitecture

public struct MapSnapshotImage: View, Equatable {
  public let data: Data

  public var body: some View {
    #if os(macOS)
    if let image = NSImage(data: data) {
      Image(nsImage: image).resizable().scaledToFit()
    }
    #else
    if let image = UIImage(data: snapshotData) {
      Image(uiImage: image).resizable()
    }
    #endif
  }
}
