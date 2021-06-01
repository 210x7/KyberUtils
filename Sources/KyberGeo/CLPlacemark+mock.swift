//
//  MockPlacemark.swift
//
//
//  Created by Cristian Díaz on 07.09.20.
//

import CoreLocation

class MockPlacemark: CLPlacemark {
  public override var administrativeArea: String? { "Mockland administrative area" }
  public override var country: String? { "Mockups Federation del Real" }
  public override var isoCountryCode: String? { "101" }
  public override var name: String? { "Mockland, Mockland 37c" }
  override var location: CLLocation? { CLLocation(latitude: 52.529088, longitude: 13.414381) }
}

extension CLPlacemark {
  public static var mock: CLPlacemark { MockPlacemark() }
}
