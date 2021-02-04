//
//  RainIntensity.swift
//  Sturmfrei
//
//  Created by Cristian Díaz on 27.07.20.
//

import Foundation
import SwiftUI

/*
 Rainfall intensity is classified according to the rate of precipitation, which depends on the considered time.
 The following categories are used to classify rainfall intensity:
 
 Light rain — when the precipitation rate is < 2.5 mm (0.098 in) per hour
 Moderate rain — when the precipitation rate is between 2.5 mm (0.098 in) - 7.6 mm (0.30 in) or 10 mm (0.39 in) per hour
 Heavy rain — when the precipitation rate is > 7.6 mm (0.30 in) per hour, or between 10 mm (0.39 in) and 50 mm (2.0 in) per hour
 Violent rain — when the precipitation rate is > 50 mm (2.0 in) per hour
 Euphemisms for a heavy or violent rain include gully washer, trash-mover and toad-strangler. The intensity can also be expressed by rainfall erosivity R-factor or in terms of the rainfall time-structure n-index.
 
 https://en.wikipedia.org/wiki/Rain#Intensity
 */

public enum RainIntensityType: CaseIterable {
  case light
  case moderate
  case heavy
  case violent
}

public extension RainIntensityType {
  //TODO: implement non metric systems
  var amount: Range<Double> {
    switch self {
    case .light:
      return 0.1..<2.5
    case .moderate:
      return 2.5..<10
    case .heavy:
      return 10..<50
    case .violent:
      return 50..<100
    }
  }
  
  static func caseFor(amount: Double) -> Self {
    switch amount {
    case 0.1..<2.5:
      return .light
    case 2.5..<10:
      return .moderate
    case 10..<50:
      return .heavy
    case 50..<100:
      return .violent
    default:
      return .light
    }
  }
  
  var formattedAmount: String {
    switch self {
    case .light:
      return "2.5 mm/h"
    case .moderate:
      return "10 mm/h"
    case .heavy:
      return "50 mm/h"
    case .violent:
      return "100 mm/h"
    }
  }
  
  var subjectiveScale: Double {
    switch self {
    case .light:
      return 2.5
    case .moderate:
      return 7.5
    case .heavy:
      return 40
    case .violent:
      return 50 
    }
  }
  
  var fontWeight: Font.Weight {
    switch self {
    case .light:
      return Font.Weight.light
    case .moderate:
      return Font.Weight.medium
    case .heavy:
      return Font.Weight.heavy
    case .violent:
      return Font.Weight.black
    }
  }
}

extension RainIntensityType: CustomStringConvertible {
  public var description: String {
    switch self {
    case .light:
      return "Light"
    case .moderate:
      return "Moderate"
    case .heavy:
      return "Heavy"
    case .violent:
      return "Violent"
    }
  }
}
