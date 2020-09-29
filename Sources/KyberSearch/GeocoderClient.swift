//
//  GeocoderClient.swift
//  Raind
//
//  Created by Cristian Díaz on 06.07.20.
//

import ComposableArchitecture
import ComposableCoreLocation
import KyberGeo

public struct GeocoderClient {
  var requestForwardGeocoding: (String) -> Effect<[CLPlacemark], Failure>
  var requestReverseGeocoding: (Location) -> Effect<[CLPlacemark], Failure>
  
  public struct Failure: Error, Equatable {}
}

public extension GeocoderClient {
  static let live = GeocoderClient(
    requestForwardGeocoding: { address in
      .future { callback in
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
          guard
            let placemarks = placemarks,
            !placemarks.isEmpty
          else { return callback(.failure(Failure())) }
          callback(.success(placemarks))
        }
      }
    },
    requestReverseGeocoding: { location in
      .future { callback in
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location.rawValue) { (placemarks, error) in
          guard
            let placemarks = placemarks,
            !placemarks.isEmpty
          else { return callback(.failure(Failure())) }
          callback(.success(placemarks))
        }
      }
    }
  )
}

public extension GeocoderClient {
  static let mock = GeocoderClient(
    requestForwardGeocoding: { _ in .result { .success([CLPlacemark.mock]) }},
    requestReverseGeocoding: { _ in .result { .success([CLPlacemark.mock]) }}
  )
}
