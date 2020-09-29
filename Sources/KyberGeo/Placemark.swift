//
//  Placemark.swift
//  Sturmfrei
//
//  Created by Cristian Díaz on 07.08.20.
//

//import ComposableCoreLocation
//import MapKit
//
//public struct Placemark {
//  public let rawValue: MKPlacemark
//  
//
//}



////
////  MKPlacemark.h
////  MapKit
////
////  Copyright (c) 2009-2014, Apple Inc. All rights reserved.
////
//
//@available(iOS 3.0, *)
//open class MKPlacemark : CLPlacemark, MKAnnotation {
//
//
//    @available(iOS 10.0, *)
//    public init(coordinate: CLLocationCoordinate2D)
//
//
//    // An address dictionary is a dictionary in the same form as returned by
//    // ABRecordCopyValue(person, kABPersonAddressProperty).
//    public init(coordinate: CLLocationCoordinate2D, addressDictionary: [String : Any]?)
//
//
//    @available(iOS 10.0, *)
//    public init(coordinate: CLLocationCoordinate2D, postalAddress: CNPostalAddress)
//
//
//    // To create an MKPlacemark from a CLPlacemark, call [MKPlacemark initWithPlacemark:] passing the CLPlacemark instance that is returned by CLGeocoder.
//    // See CLGeocoder.h and CLPlacemark.h in CoreLocation for more information.
//
//    open var countryCode: String? { get }
//}
//



//let placeholder = "--"

//public struct Coordinate: Codable, Hashable, Identifiable {
//  public var id = UUID()
//  public var latitude: CLLocationDegrees
//  public var longitude: CLLocationDegrees
//  public var rawValue: CLLocationCoordinate2D {
//    CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//  }
//
//  public init(rawValue: CLLocationCoordinate2D) {
//    self.latitude = rawValue.latitude
//    self.longitude = rawValue.longitude
//  }
//}

/*
public struct Placemark: Equatable, Hashable, Codable {
  public var administrativeArea: String?
  public var areasOfInterest: [String]?
  public var coordinate: Coordinate
  public var country: String?
  public var countryCode: String?
  public var inlandWater: String?
  public var isoCountryCode: String?
  public var locality: String?
  public var name: String?
  public var ocean: String?
  public var postalCode: String?
  //public var region: CLRegion?
  public var subAdministrativeArea: String?
  public var subLocality: String?
  public var subThoroughfare: String?
  public var subtitle: String?
  public var thoroughfare: String?
  public var title: String?
  
  public init(rawValue: MKPlacemark) {
    self.administrativeArea = rawValue.administrativeArea
    self.areasOfInterest = rawValue.areasOfInterest
    self.coordinate = Coordinate(rawValue: rawValue.coordinate)
    self.country = rawValue.country
    self.countryCode = rawValue.countryCode
    self.inlandWater = rawValue.inlandWater
    self.isoCountryCode = rawValue.isoCountryCode
    self.locality = rawValue.locality
    self.name = rawValue.name
    self.ocean = rawValue.ocean
    self.postalCode = rawValue.postalCode
    // self.region = rawValue.region
    self.subAdministrativeArea = rawValue.subAdministrativeArea
    self.subLocality = rawValue.subLocality
    self.subThoroughfare = rawValue.subThoroughfare
    self.subtitle =
      rawValue.responds(to: #selector(getter:MKPlacemark.subtitle)) ? rawValue.subtitle : nil
    self.thoroughfare = rawValue.thoroughfare
    self.title = rawValue.responds(to: #selector(getter:MKPlacemark.title)) ? rawValue.title : nil
  }
  
  public init(
    administrativeArea: String? = nil,
    areasOfInterest: [String]? = nil,
    coordinate: Coordinate = .init(),
    country: String? = nil,
    countryCode: String? = nil,
    inlandWater: String? = nil,
    isoCountryCode: String? = nil,
    locality: String? = nil,
    name: String? = nil,
    ocean: String? = nil,
    postalCode: String? = nil,
    region: CLRegion? = nil,
    subAdministrativeArea: String? = nil,
    subLocality: String? = nil,
    subThoroughfare: String? = nil,
    subtitle: String? = nil,
    thoroughfare: String? = nil,
    title: String? = nil
  ) {
    self.administrativeArea = administrativeArea
    self.areasOfInterest = areasOfInterest
    self.coordinate = coordinate
    self.country = country
    self.countryCode = countryCode
    self.inlandWater = inlandWater
    self.isoCountryCode = isoCountryCode
    self.locality = locality
    self.name = name
    self.ocean = ocean
    self.postalCode = postalCode
    // self.region = region
    self.subAdministrativeArea = subAdministrativeArea
    self.subLocality = subLocality
    self.subThoroughfare = subThoroughfare
    self.subtitle = subtitle
    self.thoroughfare = thoroughfare
    self.title = title
  }
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.administrativeArea == rhs.administrativeArea
      && lhs.areasOfInterest == rhs.areasOfInterest
      && lhs.coordinate.latitude == rhs.coordinate.latitude
      && lhs.coordinate.longitude == rhs.coordinate.longitude
      && lhs.country == rhs.country
      && lhs.countryCode == rhs.countryCode
      && lhs.inlandWater == rhs.inlandWater
      && lhs.isoCountryCode == rhs.isoCountryCode
      && lhs.locality == rhs.locality
      && lhs.name == rhs.name
      && lhs.ocean == rhs.ocean
      && lhs.postalCode == rhs.postalCode
      // && lhs.region == rhs.region
      && lhs.subAdministrativeArea == rhs.subAdministrativeArea
      && lhs.subLocality == rhs.subLocality
      && lhs.subThoroughfare == rhs.subThoroughfare
      && lhs.subtitle == rhs.subtitle
      && lhs.thoroughfare == rhs.thoroughfare
      && lhs.title == rhs.title
  }
}

public extension Placemark {
 
  var decription: String {
    
    var composed = ""
    
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
*/
