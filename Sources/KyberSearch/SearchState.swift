//
//  PlaceSearchState.swift
//  Search
//
//  Created by Cristian Díaz on 21.08.20.
//

import ComposableArchitecture
import ComposableCoreLocation

public struct SearchState: Equatable {
  public init(geocoder: GeocoderState = GeocoderState(), query: String = "", result: CLPlacemark? = nil, isCancelVisible: Bool = false, isLoading: Bool = false) {
    self.geocoder = geocoder
    self.query = query
    self.result = result
    self.isCancelVisible = isCancelVisible
    self.isLoading = isLoading
  }
  
  var geocoder: GeocoderState
  var query = ""
  public var result: CLPlacemark?
  var isCancelVisible = false
  var isLoading = false
}

public enum SearchAction: Equatable {
  case geocoder(GeocoderAction)
  case onQueryChanged(String)
  case onEditingChanged(Bool)
  case onCommit
  case cleanup
  case didSelect(CLPlacemark)
}

public struct SearchEnvironment {
  public init(geocoderClient: GeocoderClient, mainQueue: AnySchedulerOf<DispatchQueue>) {
    self.geocoderClient = geocoderClient
    self.mainQueue = mainQueue
  }
  
  var geocoderClient: GeocoderClient
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

public let searchReducer = Reducer<SearchState, SearchAction, SearchEnvironment>.combine(
  geocoderReducer.pullback(
    state: \.geocoder,
    action: /SearchAction.geocoder,
    environment: {
      GeocoderEnvironment(
        geocoderClient: $0.geocoderClient,
        mainQueue: $0.mainQueue
      )
    }
  ),
  Reducer { (state, action, environment) in
    switch action {
    
    case let .onQueryChanged(query):
      guard !query.isEmpty else {
        state.isCancelVisible = false
        state.result = nil
        return.none
      }
      struct QueryId: Hashable {}
      
      state.query = query
      state.isCancelVisible = true
      state.isLoading = true
      return Effect(value: .geocoder(.locationFromAddress(query)))        .debounce(id: QueryId(), for: 0.3, scheduler: environment.mainQueue)      
      
    case let .onEditingChanged(changed):
      // guard state.query.isEmpty else {
      //   return.none
      // }
      return .none
      
    case .onCommit:
      //state.isCancelVisible = false
      //state.isResultVisible = true
      return .none
      
    case .cleanup:
      state.query = ""
      state.isCancelVisible = false
      state.result = nil
      return .none
      
    case .didSelect(_):
      return Effect(value: .cleanup)
      
    case let .geocoder(.geocodingResponse(.success(result))):
      state.result = result.first
      state.isLoading = false
      return .none
      
    case .geocoder(.geocodingResponse(.failure)):
      state.result = nil
      state.isLoading = false
      return .none
      
    case .geocoder(_):
      return .none
    }
  }
)