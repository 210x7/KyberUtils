//
//  MapSnapshot.swift
//  
//
//  Created by Cristian Díaz on 26.01.21.
//

import SwiftUI
import ComposableArchitecture

public struct MapSnapshotImage: View, Equatable, Hashable {
  #if os(macOS)
  public let image: NSImage
  #else
  public let image: UIImage
  #endif
    
  public var body: some View {
    #if os(macOS)
    Image(nsImage: image).resizable().scaledToFit()
    #else
    Image(uiImage: image).resizable().scaledToFit()
    #endif
  }
}
