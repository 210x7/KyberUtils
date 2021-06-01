//
//  PlaceSearchState.swift
//  Search
//
//  Created by Cristian Díaz on 21.08.20.
//

import ComposableArchitecture
import ComposableCoreLocation

public struct SearchState: Equatable {
  var geocoder: GeocoderState
  var isCancelVisible: Bool
  var isInitial: Bool
  var isLoading: Bool
  var isSearchPresented: Bool
  public var query: String
  public var result: CLPlacemark?
  public var selectedPlace: CLPlacemark?

  public init(
    geocoder: GeocoderState = .init(),
    isCancelVisible: Bool = false,
    isInitial: Bool = true,
    isLoading: Bool = false,
    isSearchPresented: Bool = false,
    query: String = "",
    result: CLPlacemark? = nil
  ) {
    self.geocoder = geocoder
    self.isCancelVisible = isCancelVisible
    self.isInitial = isInitial
    self.isLoading = isLoading
    self.isSearchPresented = isSearchPresented
    self.query = query
    self.result = result
  }
}

public enum SearchAction: Equatable {
  case cleanup
  case didSelect(CLPlacemark)
  case geocoder(GeocoderAction)
  case initial(Location)
  case onQueryChanged(String)
  case onCommit
  case setSearch(isPresented: Bool)
}

public struct SearchEnvironment {
  var geocoderClient: GeocoderClient
  var mainQueue: AnySchedulerOf<DispatchQueue>

  public init(geocoderClient: GeocoderClient, mainQueue: AnySchedulerOf<DispatchQueue>) {
    self.geocoderClient = geocoderClient
    self.mainQueue = mainQueue
  }
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
    case .cleanup:
      state.isCancelVisible = false
      state.query = ""
      state.result = nil
      return .none

    case .didSelect(let place):
      state.isSearchPresented = false
      state.selectedPlace = place
      return Effect(value: .cleanup)

    case let .geocoder(.geocodingResponse(.success(result))):
      if state.isInitial {
        state.selectedPlace = result.first
        state.isInitial = false
      }
      state.isLoading = false
      state.result = result.first
      return .none

    case .geocoder(.geocodingResponse(.failure)):
      state.result = nil
      state.isLoading = false
      return .none

    case .geocoder(_):
      return .none

    case .initial(let location):
      return Effect(value: .geocoder(.addressFromLocation(location)))

    case let .onQueryChanged(query):
      guard !query.isEmpty else {
        state.isCancelVisible = false
        state.result = nil
        return .none
      }
      struct QueryId: Hashable {}

      state.isCancelVisible = true
      state.isSearchPresented = true
      state.isLoading = true
      state.query = query
      return Effect(value: .geocoder(.locationFromAddress(query)))
        .debounce(id: QueryId(), for: 0.3, scheduler: environment.mainQueue)

    case .onCommit:
      guard let place = state.result else { return .none }
      return Effect(value: .didSelect(place))

    case .setSearch(let isPresented):
      state.isSearchPresented = isPresented
      return .none
    }
  }
)
