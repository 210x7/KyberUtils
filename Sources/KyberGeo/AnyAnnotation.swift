//
//  AnyAnnotation.swift
//
//
//  Created by Cristian Díaz on 22.01.21.
//

import Foundation
import MapKit

open class AnyAnnotation: NSObject, MKAnnotation, Identifiable {

  public let coordinate: CLLocationCoordinate2D
  public let id: String
  public let subtitle: String?
  public let title: String?

  public init(
    coordinate: CLLocationCoordinate2D,
    id: String,
    subtitle: String?,
    title: String?
  ) {
    self.coordinate = coordinate
    self.id = id
    self.subtitle = subtitle
    self.title = title
    super.init()
  }
}
