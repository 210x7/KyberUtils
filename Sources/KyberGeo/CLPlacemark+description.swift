//
//  CLPlacemark+description.swift
//  
//
//  Created by Cristian Díaz on 07.09.20.
//

import CoreLocation

public extension CLPlacemark {
  var composedDescription: String {
    var composed = ""

    if let name = self.name {
      composed.append("\(name) – ")
    }
    
    if let administrativeArea = self.administrativeArea {
      composed.append("\(administrativeArea) ")
    }
    
    if let country = self.country, let isoCountryCode = self.isoCountryCode {
      composed.append("(\(country) – \(isoCountryCode))")
    }
    else {
      if let country = self.country {
        composed.append("(\(country))")
      }
      
      if let isoCountryCode = self.isoCountryCode {
        composed.append("(\(isoCountryCode))")
      }
    }
    
    return composed
  }
}

public extension CLPlacemark {
  func offsetDescription(from timezone: TimeZone = TimeZone.current) -> String? {
    guard let placemarkTimezone = self.timeZone else { return nil }
    let difference = placemarkTimezone.secondsFromGMT() - timezone.secondsFromGMT()
    let hours = difference / (60 * 60)
    
    guard hours > 0 else { return nil }
    //TODO: make proper localization (plurals, etc...)
    return "\(hours.signum() == 1 ? "+" : "")"
      + "\(hours)"
      + "\(hours == 1 || hours == -1 ? "HR" : "HRS")"
  }
}
