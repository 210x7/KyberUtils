//
//  CLPlacemark+description.swift
//
//
//  Created by Cristian Díaz on 07.09.20.
//

import CoreLocation

/* e.g

 "City" : "Berlin"
 "Country" : "Germany"
 "CountryCode" : "DE"
 "FormattedAddressLines" : 3 elements
 "Name" : "Straßburger Straße 7E"
 "State" : "Berlin"
 "Street" : "Straßburger Straße 7E"
 "SubAdministrativeArea" : "Berlin"
 "SubLocality" : "Prenzlauer Berg"
 "SubThoroughfare" : "7E"
 "Thoroughfare" : "Straßburger Straße"
 "ZIP" : "10405"

 ------------------------------------------

 "City" : "Móstoles"
 "Country" : "Spain"
 "CountryCode" : "ES"
 "FormattedAddressLines" : 2 elements
 "Name" : "Móstoles"
 "State" : "Madrid"
 "SubAdministrativeArea" : "Madrid"

 ------------------------------------------

 "City" : "Santiago de Chile"
 "Country" : "Chile"
 "CountryCode" : "CL"
 "FormattedAddressLines" : 2 elements
 "Name" : "Santiago de Chile"
 "State" : "Santiago"

 ------------------------------------------

 "Country" : "Cuba"
 "CountryCode" : "CU"
 "FormattedAddressLines" : 1 element
 "Name" : "Cuba"

 */

extension CLPlacemark {
  public var composedDescription: String {
    var composed = ""

    if let name = self.name {
      composed.append("\(name) – ")
    }

    if let administrativeArea = self.administrativeArea {
      composed.append("\(administrativeArea) ")
    }

    if let country = self.country, let isoCountryCode = self.isoCountryCode {
      composed.append("(\(country) – \(isoCountryCode))")
    } else {
      if let country = self.country {
        composed.append("(\(country))")
      }

      if let isoCountryCode = self.isoCountryCode {
        composed.append("(\(isoCountryCode))")
      }
    }

    return composed
  }

  public var composedTitle: String {
    
    var composedStart = ""
    if let subLocality = self.subLocality {
      composedStart.append("\(subLocality) ")
    } else if let locality = self.locality {
      composedStart.append("\(locality)")
    } else if let name = self.name {
      composedStart.append("\(name)")
    }

    var composedEnd = ""
    if let _ = self.subLocality, let locality = self.locality {
      composedEnd.append("\(locality)")
    } else if let subAdministrativeArea = self.subAdministrativeArea {
      composedEnd.append("\(subAdministrativeArea)")
    } else if let administrativeArea = self.administrativeArea {
      composedEnd.append("\(administrativeArea)")
    }

    var composed: String {
      if composedStart == composedEnd {
        return composedStart
      } else {
        return composedStart + " — " + composedEnd
      }
    }
    
    return composed
  }

  public var composedSubtitle: String {
    var composed = ""

    if let administrativeArea = self.administrativeArea {
      composed.append("\(administrativeArea) ")
    }

    if let country = self.country, let isoCountryCode = self.isoCountryCode {
      composed.append("(\(country) – \(isoCountryCode))")
    } else {
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

extension CLPlacemark {
  public func offsetDescription(from timezone: TimeZone = TimeZone.current) -> String? {
    guard let placemarkTimezone = self.timeZone else { return nil }
    let difference = placemarkTimezone.secondsFromGMT() - timezone.secondsFromGMT()
    let hours = difference / (60 * 60)

    guard hours != 0 else { return nil }
    //TODO: make proper localization (plurals, etc...)
    return "\(hours.signum() == 1 ? "+" : "")"
      + "\(hours)"
      + "\(hours == 1 || hours == -1 ? "HR" : "HRS")"
  }
}
