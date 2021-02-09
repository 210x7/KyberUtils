//
//  Helpers.swift
//  Sturmfrei
//
//  Created by Cristian Díaz (work) on 04.07.20.
//

import Foundation
import SwiftUI

public let formatterPlaceholder = "--"

public let ISO8601Formatter: ISO8601DateFormatter = {
  let formatter = ISO8601DateFormatter()
  formatter.timeZone = TimeZone.current
  formatter.formatOptions = [
    .withColonSeparatorInTime,
    .withColonSeparatorInTimeZone,
    .withDashSeparatorInDate,
    .withYear,
    .withMonth,
    .withDay,
    .withTime,
    .withTimeZone
  ]
  return formatter
}()

public let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.dateFormat = "HH:mm"
  return formatter
}()

public let numberFormatter: NumberFormatter = {
  let formatter = NumberFormatter()
  formatter.maximumFractionDigits = 1
  formatter.roundingMode = .up
  return formatter
}()

public let measurementFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.unitStyle = .short
  formatter.numberFormatter.maximumFractionDigits = 1
  return formatter
}()

public let temperatureFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.unitStyle = .short
  formatter.numberFormatter.maximumFractionDigits = 0
  return formatter
}()

public let mediumTemperatureFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.unitStyle = .medium
  formatter.numberFormatter.maximumFractionDigits = 0
  return formatter
}()

public let distanceFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.unitOptions = .naturalScale
  formatter.numberFormatter.maximumFractionDigits = 0
  return formatter
}()

public let precipitationFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.unitStyle = .short
  formatter.unitOptions = .providedUnit
  formatter.numberFormatter.maximumFractionDigits = 1
  return formatter
}()


public let windFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.unitStyle = .short
  formatter.unitOptions = .providedUnit
  formatter.numberFormatter.maximumFractionDigits = 0
  return formatter
}()

public let speedFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.unitStyle = .short
  formatter.unitOptions = .naturalScale
  formatter.numberFormatter.maximumFractionDigits = 0
  return formatter
}()

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
