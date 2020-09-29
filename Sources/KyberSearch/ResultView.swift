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
  public init(store: Store<KyberSearch, KyberSearchAction>, placemark: CLPlacemark) {
    self.store = store
    self.placemark = placemark
  }
  
  let store: Store<KyberSearch, KyberSearchAction>
  let placemark: CLPlacemark
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.screenPosition) var screenPosition
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      Button(
        action: { viewStore.send(.didSelect(placemark)) },
        label: {
          VStack {
            if let location = placemark.location {
              switch screenPosition {
              case .top:
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

extension CLLocationCoordinate2D: Identifiable {
  public var id: String {
    "\(self.latitude), \(self.longitude)"
  }
}
