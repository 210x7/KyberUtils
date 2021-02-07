//
//  PlaceState.swift
//  
//
//  Created by Cristian Díaz on 31.08.20.
//

import ComposableArchitecture
import ComposableCoreLocation
import Foundation

public struct PlaceState: Equatable {
  public init(place: CLPlacemark? = nil, geocoder: GeocoderState = GeocoderState()) {
    self.placemark = place
    self.geocoder = geocoder
  }
  
  public var placemark: CLPlacemark?
  var geocoder: GeocoderState
}

public enum PlaceAction: Equatable {
  case geocoder(GeocoderAction)
  case placeFrom(location: Location)
  case didFound
}

public struct PlaceEnvironment {
  public init(geocoderClient: GeocoderClient, mainQueue: AnySchedulerOf<DispatchQueue>) {
    self.geocoderClient = geocoderClient
    self.mainQueue = mainQueue
  }
  
  var geocoderClient: GeocoderClient
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

public let placeReducer = Reducer<PlaceState, PlaceAction, PlaceEnvironment>.combine(
  geocoderReducer.pullback(
    state: \PlaceState.geocoder,
    action: /PlaceAction.geocoder,
    environment: {
      GeocoderEnvironment(
        geocoderClient: $0.geocoderClient,
        mainQueue: $0.mainQueue
      )
    }
  ),
  Reducer { (state, action, environment) in
    switch action {
    
    case let .placeFrom(location: location):
      return Effect(value: .geocoder(.addressFromLocation(location)))
      
    case .didFound:
      return .none
      
    case let .geocoder(.geocodingResponse(.success(result))):
      state.placemark = result.first
      return Effect(value: .didFound)
      
    case .geocoder(_):
      return .none
    }
  }
)
