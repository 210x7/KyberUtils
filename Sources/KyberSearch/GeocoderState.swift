//
//  GeocoderState.swift
//  Raind
//
//  Created by Cristian Díaz (work) on 03.07.20.
//

import ComposableArchitecture
import ComposableCoreLocation

public struct GeocoderState: Equatable {
  var places: [CLPlacemark]
  
  public init(places: [CLPlacemark] = []) {
    self.places = places
  }
}

public enum GeocoderAction: Equatable {
  case locationFromAddress(String)
  case addressFromLocation(Location)
  case geocodingResponse(Result<[CLPlacemark], GeocoderClient.Failure>)
}

public struct GeocoderEnvironment {
  var geocoderClient: GeocoderClient
  var mainQueue: AnySchedulerOf<DispatchQueue>
  
  public init(geocoderClient: GeocoderClient, mainQueue: AnySchedulerOf<DispatchQueue>) {
    self.geocoderClient = geocoderClient
    self.mainQueue = mainQueue
  }
}

public let geocoderReducer = Reducer<GeocoderState, GeocoderAction, GeocoderEnvironment>.combine(
  Reducer { state, action, environment in
    switch action {
    case let .locationFromAddress(address):
      struct QueryId: Hashable {}
            
      // When the query is cleared we can clear the search results, but we have to make sure to cancel
      // any in-flight search requests too, otherwise we may get data coming in later.
      guard !address.isEmpty else {
        state.places.removeAll()
        return .cancel(id: QueryId())
      }
      return environment.geocoderClient
        .requestForwardGeocoding(address)
        .receive(on: environment.mainQueue)
        .catchToEffect()
        .debounce(id: QueryId(), for: 0.5, scheduler: environment.mainQueue)
        .map(GeocoderAction.geocodingResponse)
      
    case let .addressFromLocation(location):
      struct QueryId: Hashable {}
      return environment.geocoderClient
        .requestReverseGeocoding(location)
        .receive(on: environment.mainQueue)
        .catchToEffect()
        .debounce(id: QueryId(), for: 0.5, scheduler: environment.mainQueue)
        .map(GeocoderAction.geocodingResponse)
      
    case let .geocodingResponse(.success(result)):
      state.places = result
      return .none
      
    case .geocodingResponse(.failure):
      state.places.removeAll()
      return .none
    }
  }
)
