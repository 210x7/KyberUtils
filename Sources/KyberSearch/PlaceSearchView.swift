//
//  PlaceSearchView.swift
//  
//
//  Created by Cristian Díaz on 22.08.20.
//

import ComposableArchitecture
import SwiftUI

public struct PlaceSearchView: View {
  public init(store: Store<KyberSearch, KyberSearchAction>) {
    self.store = store
  }
  
  let store: Store<KyberSearch, KyberSearchAction>
  @Environment(\.screenPosition) var screenPosition
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      VStack(alignment: .leading) {
        switch screenPosition {
        case .top:
          SearchBarView(store: store).padding(12)
          if let placemark = viewStore.result {
            Divider()
            ResultView(store: store, placemark: placemark)
          }
          
        case .bottom:
          if let placemark = viewStore.result {
            ResultView(store: store, placemark: placemark)
            Divider()
          }
          SearchBarView(store: store).padding(12)
        }
      }
      //FIXME: conditional #if os(macOS) style
      //.background(Rectangle().fill(Color(.secondarySystemBackground)))
      .clipShape(RoundedRectangle(cornerRadius: 8))
      //FIXME: conditional #if os(macOS) style
      // .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color(.systemBackground)).padding(1))
      // .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.secondarySystemFill)))
      .animation(.easeOut(duration: 0.2))
    }
  }
}


public enum SearchScreenPosition {
  case top
  case bottom
}

public struct PlaceSearchSettings: EnvironmentKey {
  public static var defaultValue: SearchScreenPosition = .top
}

public extension EnvironmentValues {
  var screenPosition: SearchScreenPosition {
    get { self[PlaceSearchSettings.self] }
    set { self[PlaceSearchSettings.self] = newValue }
  }
}
