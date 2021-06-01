//
//  BoundingBox.swift
//  Sturmfrei
//
//  Created by Cristian Díaz on 07.07.20.
//

import Foundation
import MapKit

public struct BoundingBox {
  public let nw: CLLocationCoordinate2D
  public let ne: CLLocationCoordinate2D
  public let se: CLLocationCoordinate2D
  public let sw: CLLocationCoordinate2D
  public let center: CLLocationCoordinate2D
}

extension BoundingBox {
  public var region: MKCoordinateRegion? {
    MKCoordinateRegion(coordinates: [nw, se])
  }
}

extension BoundingBox {
  public init(mapRect: MKMapRect) {
    let nw = MKMapPoint(x: mapRect.origin.x, y: mapRect.origin.y)
    let ne = MKMapPoint(x: mapRect.maxX, y: mapRect.origin.y)
    let se = MKMapPoint(x: mapRect.maxX, y: mapRect.maxY)
    let sw = MKMapPoint(x: mapRect.origin.x, y: mapRect.maxY)
    let center = MKMapPoint(x: mapRect.midX, y: mapRect.midY)

    self.nw = nw.coordinate
    self.ne = ne.coordinate
    self.se = se.coordinate
    self.sw = sw.coordinate
    self.center = center.coordinate
  }
}

extension BoundingBox {
  public init(region: MKCoordinateRegion) {
    let nw = CLLocationCoordinate2D(
      latitude: region.center.latitude - (region.span.latitudeDelta / 2),
      longitude: region.center.longitude + (region.span.longitudeDelta / 2)
    )
    let ne = CLLocationCoordinate2D(
      latitude: region.center.latitude + (region.span.latitudeDelta / 2),
      longitude: region.center.longitude + (region.span.longitudeDelta / 2)
    )
    let se = CLLocationCoordinate2D(
      latitude: region.center.latitude + (region.span.latitudeDelta / 2),
      longitude: region.center.longitude - (region.span.longitudeDelta / 2)
    )
    let sw = CLLocationCoordinate2D(
      latitude: region.center.latitude - (region.span.latitudeDelta / 2),
      longitude: region.center.longitude - (region.span.longitudeDelta / 2)
    )

    self.nw = nw
    self.ne = ne
    self.se = se
    self.sw = sw
    self.center = region.center
  }
}

extension BoundingBox {
  public init(coordinate: CLLocationCoordinate2D, regionSpan: Double = 0.35) {
    var region = MKCoordinateRegion()
    region.center = coordinate
    region.span.latitudeDelta = regionSpan
    region.span.longitudeDelta = regionSpan
    self.init(region: region)
  }
}

extension BoundingBox {
  public init(location: CLLocation, regionSpan: Double = 0.35) {
    var region = MKCoordinateRegion()
    region.center = location.coordinate
    region.span.latitudeDelta = regionSpan
    region.span.longitudeDelta = regionSpan
    self.init(region: region)
  }
}

extension BoundingBox: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.center.latitude == rhs.center.latitude
      && lhs.center.longitude == rhs.center.longitude
      && lhs.nw.latitude == rhs.nw.latitude
      && lhs.nw.longitude == rhs.nw.longitude
      && lhs.ne.latitude == rhs.ne.latitude
      && lhs.ne.longitude == rhs.ne.longitude
      && lhs.se.latitude == rhs.se.latitude
      && lhs.se.longitude == rhs.se.longitude
      && lhs.sw.latitude == rhs.sw.latitude
      && lhs.sw.longitude == rhs.sw.longitude
  }
}

extension BoundingBox: CustomStringConvertible {
  public var description: String {
    "\(nw.latitude),\(se.longitude),\(se.latitude),\(nw.longitude)"
  }
}

#if DEBUG
  extension BoundingBox {
    public static let mock = Self(
      coordinate: .init(
        latitude: 52.529109,
        longitude: 13.414543
      )
    )
  }
#endif
