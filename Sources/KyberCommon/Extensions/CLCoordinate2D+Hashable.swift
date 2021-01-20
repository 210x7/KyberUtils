//
//  CLCoordinate2D+Hashable.swift
//  Sturmfrei
//
//  Created by Cristian Díaz (work) on 04.07.20.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: Equatable, Hashable {
  public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    lhs.latitude == rhs.latitude &&
      lhs.longitude == rhs.longitude
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(latitude + longitude)
  }
}
