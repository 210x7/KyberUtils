//
//  MapSnapshotClient.swift
//  
//
//  Created by Cristian Díaz on 26.01.21.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

import ComposableArchitecture
import MapKit

public struct MapSnapshotClient {
  public var makeSnapshot: (String, CoordinateRegion, CGSize) -> Effect<MapSnapshotImage, Failure>
  
  public enum Failure: Error {
    case mapSnapshotterError
  }
}

public extension MapSnapshotClient {
  static let live = MapSnapshotClient { (id, region, size) -> Effect<MapSnapshotImage, Failure> in
    .future { callback in
      let mapSnapshotOptions = MKMapSnapshotter.Options()
      mapSnapshotOptions.region = region.asMKCoordinateRegion
      #if os(iOS)
      mapSnapshotOptions.scale = UIScreen.main.scale
      #endif
      mapSnapshotOptions.size = size
      mapSnapshotOptions.showsBuildings = false
      mapSnapshotOptions.mapType = MKMapType.hybridFlyover
      //TODO: complete POI filter
      // mapSnapshotOptions.pointOfInterestFilter = MKPointOfInterestFilter(excluding: [.airport])
      
      let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
      snapShotter.start { (snap, error) in
        guard let image = snap?.image else { return callback(.failure(.mapSnapshotterError)) }
        callback(.success(MapSnapshotImage(image: image)))
      }
    }
  }
}
