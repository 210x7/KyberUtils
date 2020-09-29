//
//  CurrentPlace.swift
//  
//
//  Created by Cristian Díaz on 31.08.20.
//

import ComposableArchitecture
import ComposableCoreLocation
import Foundation

public struct CurrentPlace: Equatable {
  public init(place: CLPlacemark? = nil, geocoder: GeocoderState = GeocoderState()) {
    self.place = place
    self.geocoder = geocoder
  }
  
  public var place: CLPlacemark?
  var geocoder: GeocoderState
}

public enum CurrentPlaceAction: Equatable {
  case geocoder(GeocoderAction)
  case placeFrom(location: Location)
  case didFound
}

public struct CurrentPlaceEnvironment {
  public init(geocoderClient: GeocoderClient, mainQueue: AnySchedulerOf<DispatchQueue>) {
    self.geocoderClient = geocoderClient
    self.mainQueue = mainQueue
  }
  
  var geocoderClient: GeocoderClient
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

public let currentPlaceReducer = Reducer<CurrentPlace, CurrentPlaceAction, CurrentPlaceEnvironment>.combine(
  geocoderReducer.pullback(
    state: \CurrentPlace.geocoder,
    action: /CurrentPlaceAction.geocoder,
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
      state.place = result.first
      return Effect(value: .didFound)
      
    case .geocoder(_):
      return .none
    }
  }
)
