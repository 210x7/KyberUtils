//
//  MKCoordinateRegion+MKMapRect.swift
//  Sturmfrei
//
//  Created by Cristian Díaz on 07.07.20.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
  var mapRect: MKMapRect {
    let topLeft = CLLocationCoordinate2D(
      latitude: self.center.latitude + (self.span.latitudeDelta/2),
      longitude: self.center.longitude - (self.span.longitudeDelta/2))
    let bottomRight = CLLocationCoordinate2D(
      latitude: self.center.latitude - (self.span.latitudeDelta/2),
      longitude: self.center.longitude + (self.span.longitudeDelta/2))
    
    let a = MKMapPoint(topLeft)
    let b = MKMapPoint(bottomRight)
    
    return MKMapRect(
      origin: MKMapPoint(x: min(a.x,b.x), y: min(a.y,b.y)),
      size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y)))
  }
}
