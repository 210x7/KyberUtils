//
//  Color.swift
//  
//
//  Created by Cristian Díaz on 11.02.21.
//

import Foundation
import SwiftUI

#if os(macOS)
public func colorFrom(precipitation: Double) -> NSColor {
  guard precipitation > 0 else { return .quaternaryLabelColor }
  let hue = (((300 + precipitation * 30) * .pi / 180) / 10)
  return NSColor(
    hue: CGFloat(hue),
    saturation: 1.0,
    brightness: 1.0,
    alpha: 1.0
  )
}
#else
public func colorFrom(precipitation: Double) -> UIColor {
  guard precipitation > 0 else { return .quaternaryLabel }
  let hue = (((300 + precipitation * 30) * .pi / 180) / 10)
  return UIColor(
    hue: CGFloat(hue),
    saturation: 1.0,
    brightness: 1.0,
    alpha: 1.0
  )
}
#endif

#if os(macOS)
public func colorFrom(temperature: Double) -> NSColor {
  let hue = ((300 + temperature * 10) * .pi / 180) / 10
  return NSColor(
    hue: CGFloat(hue),
    saturation: 1.0,
    brightness: 1.0,
    alpha: 1.0
  )
}
#else
public func colorFrom(temperature: Double) -> UIColor {
  let hue = ((300 + temperature * 10) * .pi / 180) / 10
  return UIColor(
    hue: CGFloat(hue),
    saturation: 1.0,
    brightness: 1.0,
    alpha: 1.0
  )
}
#endif

//TODO: implement as function
//private var timeZoneOffsetDescription: String {
//  let currentTimezoneOffset = TimeZone.current.secondsFromGMT()
//  let providedTimeZoneOffset = ViewStore(store).place.timeZone.secondsFromGMT()
//  let difference = providedTimeZoneOffset - currentTimezoneOffset
//  let hours = difference / (60 * 60)
//  if hours == 0 {
//    return ""
//  }
//  else {
//    //TODO: make proper localization (plurals, etc...)
//    return "\(hours.signum() == 1 ? "+" : "")" + "\(hours)\(hours == 1 || hours == -1 ? "HR": "HRS")"
//  }
//}
