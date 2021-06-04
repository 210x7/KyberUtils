//
//  Formatters.swift
//  Sturmfrei
//
//  Created by Cristian Díaz (work) on 04.07.20.
//

import Foundation

public let distanceFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.numberFormatter.maximumFractionDigits = 0
  formatter.unitOptions = [.naturalScale]
  return formatter
}()

public let durationFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.unitOptions = [.naturalScale]
  return formatter
}()

public let heightFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.numberFormatter.maximumFractionDigits = 0
  formatter.unitOptions = [.naturalScale]
  return formatter
}()

public let humidityFormatter: NumberFormatter = {
  let formatter = NumberFormatter()
  formatter.numberStyle = .percent
  formatter.multiplier = 1.00
  return formatter
}()

public let precipitationFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.unitStyle = .short
  formatter.numberFormatter.maximumFractionDigits = 1
  formatter.unitOptions = [.naturalScale]
  return formatter
}()

public let pressureFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.numberFormatter.maximumFractionDigits = 0
  return formatter
}()

public let speedFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.unitStyle = .short
  formatter.numberFormatter.maximumFractionDigits = 0
  formatter.unitOptions = [.naturalScale]
  return formatter
}()

public let temperatureFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.numberFormatter.maximumFractionDigits = 0
  formatter.unitOptions = [.temperatureWithoutUnit]
  return formatter
}()

public let weekdayFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "EEEEE"
  return formatter
}()
