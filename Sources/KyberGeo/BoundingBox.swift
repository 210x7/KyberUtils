//
//  BoundingBox.swift
//  Sturmfrei
//
//  Created by Cristian Díaz on 07.07.20.
//

import Foundation
import MapKit

//TODO: make test for contructors
public struct BoundingBox {
  public let nw: CLLocationCoordinate2D
  public let ne: CLLocationCoordinate2D
  public let se: CLLocationCoordinate2D
  public let sw: CLLocationCoordinate2D
  public let center: CLLocationCoordinate2D
  
  public init(mapRect: MKMapRect) {
    let topLeft = MKMapPoint(x: mapRect.origin.x, y: mapRect.origin.y)
    let topRight = MKMapPoint(x: mapRect.maxX, y: mapRect.origin.y)
    let bottomRight = MKMapPoint(x: mapRect.maxX, y: mapRect.maxY)
    let bottomLeft = MKMapPoint(x: mapRect.origin.x, y: mapRect.maxY)
    let center = MKMapPoint(x: mapRect.midX, y: mapRect.midY)
    
    self.nw = topLeft.coordinate
    self.ne = topRight.coordinate
    self.se = bottomRight.coordinate
    self.sw = bottomLeft.coordinate
    self.center = center.coordinate
  }
  
  public init(region: MKCoordinateRegion) {
    let topLeft = CLLocationCoordinate2D(
      latitude: region.center.latitude - (region.span.latitudeDelta/2),
      longitude: region.center.longitude + (region.span.longitudeDelta/2)
    )
    let topRight = CLLocationCoordinate2D(
      latitude: region.center.latitude + (region.span.latitudeDelta/2),
      longitude: region.center.longitude + (region.span.longitudeDelta/2)
    )
    let bottomRight = CLLocationCoordinate2D(
      latitude: region.center.latitude + (region.span.latitudeDelta/2),
      longitude: region.center.longitude - (region.span.longitudeDelta/2)
    )
    let bottomLeft = CLLocationCoordinate2D(
      latitude: region.center.latitude - (region.span.latitudeDelta/2),
      longitude: region.center.longitude - (region.span.longitudeDelta/2)
    )
    
    self.nw = topLeft
    self.ne = topRight
    self.se = bottomRight
    self.sw = bottomLeft
    self.center = region.center
  }
  
  public init(coordinate: CLLocationCoordinate2D, regionSpan: Double = 0.25) {
    var region = MKCoordinateRegion()
    region.center = coordinate
    region.span.latitudeDelta = regionSpan
    region.span.longitudeDelta = regionSpan
    self.init(region: region)
  }
  
  public init(location: CLLocation, regionSpan: Double = 0.25) {
    var region = MKCoordinateRegion()
    region.center = location.coordinate
    region.span.latitudeDelta = regionSpan
    region.span.longitudeDelta = regionSpan
    self.init(region: region)
  }
}

extension BoundingBox: Equatable {
  public static func == (lhs: BoundingBox, rhs: BoundingBox) -> Bool {
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
