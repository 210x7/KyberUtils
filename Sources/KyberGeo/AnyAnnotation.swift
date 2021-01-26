//
//  AnyAnnotation.swift
//  
//
//  Created by Cristian Díaz on 22.01.21.
//

import Foundation
import MapKit

open class AnyAnnotation: NSObject, MKAnnotation, Identifiable {
  
  public let id: String
  public let coordinate: CLLocationCoordinate2D
  public let title: String?
  public let subtitle: String?
  
  public init(id: String, coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
    self.id = id
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
    super.init()
  }
}
