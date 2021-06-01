//
//  ResultView.swift
//
//
//  Created by Cristian Díaz on 22.08.20.
//

import ComposableArchitecture
import ComposableCoreLocation
import MapKit
import SwiftUI

public struct ResultView: View {
  public init(store: Store<SearchState, SearchAction>, placemark: CLPlacemark) {
    self.store = store
    self.placemark = placemark
  }

  let store: Store<SearchState, SearchAction>
  let placemark: CLPlacemark
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.resultPosition) var resultPosition

  public var body: some View {
    WithViewStore(store) { viewStore in
      Button(
        action: { viewStore.send(.didSelect(placemark)) },
        label: {
          VStack {
            if let location = placemark.location {
              switch resultPosition {
              case .top, .none:
                HStack {
                  Text("—")
                  VStack(alignment: .leading) {
                    if let name = placemark.name {
                      Text(name).font(.headline)
                    }

                    if !placemark.composedDescription.isEmpty {
                      Text(placemark.composedDescription)
                        .foregroundColor(.blue)
                        .font(.footnote)
                        .underline()
                    }
                  }
                  Spacer()
                  Image(systemName: "chevron.right")
                }
                .padding(.trailing)

                Map(
                  coordinateRegion: .constant(
                    MKCoordinateRegion(
                      center: location.coordinate,
                      span: MKCoordinateSpan(latitudeDelta: 100.0, longitudeDelta: 100.0)
                    )
                  ),
                  annotationItems: [location.coordinate]
                ) { (location) -> MapPin in
                  MapPin(coordinate: location, tint: (colorScheme == .dark) ? .accentColor : .black)
                }
                .frame(minHeight: 100, maxHeight: 300)

              case .bottom:
                Map(
                  coordinateRegion: .constant(
                    MKCoordinateRegion(
                      center: location.coordinate,
                      span: MKCoordinateSpan(latitudeDelta: 100.0, longitudeDelta: 100.0)
                    )
                  ),
                  annotationItems: [location.coordinate]
                ) { (location) -> MapPin in
                  MapPin(coordinate: location, tint: (colorScheme == .dark) ? .accentColor : .black)
                }
                .frame(minHeight: 100, maxHeight: 300)

                HStack {
                  Text("—")
                  VStack(alignment: .leading) {
                    if let name = placemark.name {
                      Text(name).font(.headline)
                    }

                    if !placemark.composedDescription.isEmpty {
                      Text(placemark.composedDescription)
                        .foregroundColor(.blue)
                        .font(.footnote)
                        .underline()
                    }
                  }
                  Spacer()
                  Image(systemName: "chevron.right")
                }
                .padding(.trailing)
              }
            }
          }
        }
      )
      .buttonStyle(PlainButtonStyle())
    }
  }
}

public struct ResultView2: View {
  @Environment(\.colorScheme) var colorScheme
  let placemark: CLPlacemark?
  let store: Store<SearchState, SearchAction>

  public init(
    placemark: CLPlacemark?,
    store: Store<SearchState, SearchAction>
  ) {
    self.placemark = placemark
    self.store = store
  }

  public var body: some View {
    WithViewStore(store) { viewStore in
      if viewStore.isSearchPresented {
        Button(
          action: {
            if let placemark = placemark {
              viewStore.send(.didSelect(placemark))
            }
          },
          label: {
            // VStack {
            // Map(
            //   coordinateRegion: .constant(
            //     MKCoordinateRegion(
            //       center: location.coordinate,
            //       span: MKCoordinateSpan(latitudeDelta: 100.0, longitudeDelta: 100.0)
            //     )
            //   ),
            //   annotationItems: [location.coordinate]
            // ) { (location) -> MapPin in
            //   MapPin(coordinate: location, tint: (colorScheme == .dark) ? .accentColor : .black)
            // }
            // .frame(minHeight: 100, maxHeight: 300)

            if viewStore.isLoading {
              ProgressView()
                // .scaleEffect(x: 1, y: 0.5, anchor: .center)
                .progressViewStyle(LinearProgressViewStyle())
            } else {
              HStack {
                let name = placemark?.name
                let placemarkDescription = placemark?.composedSubtitle
                if (name != nil) || (placemarkDescription != nil) {
                  Image(systemName: "magnifyingglass")
                  VStack(alignment: .leading) {
                    if let name = name {
                      Text(name).font(.headline)
                    }

                    if let placemarkDescription = placemarkDescription,
                      placemarkDescription.isEmpty == false
                    {
                      Text(placemarkDescription)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                  }
                  .padding(.trailing)

                } else {
                  Text("No Results")
                }
              }
              Spacer()
            }
            // }
          }
        )
        .buttonStyle(PlainButtonStyle())
      }
    }
  }
}

extension CLLocationCoordinate2D: Identifiable {
  public var id: String {
    "\(self.latitude), \(self.longitude)"
  }
}
