//
//  SearchBarView.swift
//  
//
//  Created by Cristian Díaz on 22.08.20.
//

import ComposableArchitecture
import SwiftUI

public struct SearchBarView: View {
  public init(store: Store<KyberSearch, KyberSearchAction>) {
    self.store = store
  }
  
  let store: Store<KyberSearch, KyberSearchAction>
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        ZStack {
          if viewStore.isLoading {
            ProgressView()
          } else {
            Image(systemName: "magnifyingglass")
              .font(.callout)
              //FIXME: conditional #if os(macOS) style
              //.foregroundColor(Color(.secondaryLabel))
          }
        }
        .frame(width: 16, height: 16)
        
        TextField(
          "Search",
          text: viewStore.binding(
            get: { $0.query },
            send: KyberSearchAction.onQueryChanged
          ),
          onEditingChanged: { viewStore.send(.onEditingChanged($0)) },
          onCommit: { viewStore.send(.onCommit) }
        )
        .font(.headline)
        .disableAutocorrection(true)
        //FIXME: conditional #if os(macOS) style
        //.keyboardType(.alphabet)
        
        if viewStore.isCancelVisible {
          Button(
            action: { viewStore.send(.cleanup) },
            label: {
              Image(systemName: "xmark.circle.fill")
                .frame(width: 22, height: 22)
            }
          )
          .animation(.easeInOut)
          .transition(AnyTransition.move(edge: .trailing).combined(with: .opacity))
        }
      }
    }
  }
}
