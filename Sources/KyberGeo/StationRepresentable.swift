//
//  StationRepresentable.swift
//
//
//  Created by Cristian Díaz on 29.05.21.
//

import CoreLocation
import Foundation

public protocol StationRepresentable {
  var calloutView: MapCalloutView? { get }
  var coordinate: CLLocationCoordinate2D { get }
  var subtitle: String? { get }
  var title: String? { get }
}

public final class AnyStationRepresentable: StationRepresentable {
  public var calloutView: MapCalloutView?
  public var coordinate: CLLocationCoordinate2D { self.wrapped.coordinate }
  public var subtitle: String? { self.wrapped.subtitle }
  public var title: String? { self.wrapped.title }
  private let wrapped: StationRepresentable

  public init(wrapped: StationRepresentable) {
    self.wrapped = wrapped
  }
}

extension AnyStationRepresentable: Hashable {
  public static func == (lhs: AnyStationRepresentable, rhs: AnyStationRepresentable) -> Bool {
    lhs.coordinate.latitude == rhs.coordinate.latitude
      && lhs.coordinate.longitude == rhs.coordinate.longitude
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(coordinate.latitude)
    hasher.combine(coordinate.longitude)
  }
}
