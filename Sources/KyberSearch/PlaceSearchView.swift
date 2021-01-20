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
  @Environment(\.resultPosition) var resultPosition
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      VStack(alignment: .leading) {
        switch resultPosition {
        case .top:
          SearchBarView(store: store)
          if let placemark = viewStore.result {
            Divider()
            ResultView(store: store, placemark: placemark)
          }
          
        case .bottom:
          if let placemark = viewStore.result {
            ResultView(store: store, placemark: placemark)
            Divider()
          }
          SearchBarView(store: store)
        
        case .none:
          SearchBarView(store: store)
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


public enum SearchResultPosition {
  case none
  case top
  case bottom
}

public struct SearchSettings: EnvironmentKey {
  public static var defaultValue: SearchResultPosition = .top
}

public extension EnvironmentValues {
  var resultPosition: SearchResultPosition {
    get { self[SearchSettings.self] }
    set { self[SearchSettings.self] = newValue }
  }
}
