//
//  SearchBarView.swift
//
//
//  Created by Cristian Díaz on 22.08.20.
//

import ComposableArchitecture
import SwiftUI

public struct SearchBarView: View {
  public init(store: Store<SearchState, SearchAction>) {
    self.store = store
  }

  let store: Store<SearchState, SearchAction>

  public var body: some View {
    WithViewStore(store) { viewStore in
      #if os(macOS)
        SearchFieldRepresentable(viewStore: viewStore)
      #else
        HStack {
          ZStack {
            if viewStore.isLoading {
              ProgressView()
                .scaleEffect(0.5, anchor: .center)
            } else {
              Image(systemName: "magnifyingglass")
                .font(.callout)
              //FIXME: conditional #if os(macOS) style
              //.foregroundColor(Color(.secondaryLabel))
            }
          }
          .frame(width: 22, height: 22)

          TextField(
            "Search for a place or address",
            text: viewStore.binding(
              get: { $0.query },
              send: SearchAction.onQueryChanged
            ),
            onEditingChanged: { viewStore.send(.onEditingChanged($0)) },
            onCommit: { viewStore.send(.onCommit) }
          )
          .textFieldStyle(RoundedBorderTextFieldStyle())
          // .font(.headline)
          .disableAutocorrection(true)
          //FIXME: conditional #if os(macOS) style
          //.keyboardType(.alphabet)

          if viewStore.isCancelVisible {
            Button(
              action: { viewStore.send(.cleanup) },
              label: {
                Image(systemName: "xmark.circle.fill")
                  .font(.callout)
                  .frame(width: 22, height: 22)
              }
            )
            .animation(.easeInOut)
            .transition(AnyTransition.move(edge: .trailing).combined(with: .opacity))
          }
        }
      #endif
    }
  }
}

struct SearchFieldRepresentable: NSViewRepresentable {

  let viewStore: ViewStore<SearchState, SearchAction>

  public func makeNSView(context: Context) -> NSSearchField {
    let nsView = NSSearchField()
    nsView.placeholderString = "Search for a place or address"
    nsView.delegate = context.coordinator
    nsView.target = context.coordinator
    nsView.action = #selector(context.coordinator.performAction(_:))

    // nsView.translatesAutoresizingMaskIntoConstraints = false
    // nsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
    // nsView.font = NSFont.systemFont(ofSize: NSFont.systemFontSize(for: .large))

    nsView.bezelStyle = .roundedBezel
    nsView.cell?.sendsActionOnEndEditing = false
    nsView.isBordered = false
    nsView.isBezeled = true

    return nsView
  }

  public func updateNSView(_ nsView: NSSearchField, context: Context) {
    nsView.font = NSFont.systemFont(ofSize: NSFont.systemFontSize(for: .large))

  }

  final public class Coordinator: NSObject, NSSearchFieldDelegate {
    var base: SearchFieldRepresentable

    init(base: SearchFieldRepresentable) {
      self.base = base
    }

    public func controlTextDidChange(_ notification: Notification) {
      guard let textField = notification.object as? NSTextField else {
        return
      }

      base.viewStore.send(.onQueryChanged(textField.stringValue))
    }

    public func controlTextDidBeginEditing(_ notification: Notification) {
      //base.onEditingChanged(true)
    }

    public func controlTextDidEndEditing(_ notification: Notification) {
      if let placemark = base.viewStore.result {
        base.viewStore.send(.didSelect(placemark))
      }
    }

    @objc
    fileprivate func performAction(_ sender: NSTextField?) {
      //base.onCommit()
    }
  }

  public func makeCoordinator() -> Coordinator {
    Coordinator(base: self)
  }
}
