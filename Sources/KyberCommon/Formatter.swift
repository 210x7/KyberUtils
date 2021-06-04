//
//  Formatters.swift
//  Sturmfrei
//
//  Created by Cristian Díaz (work) on 04.07.20.
//

import Foundation

public let temperatureFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.numberFormatter.maximumFractionDigits = 0
  formatter.unitOptions = [.temperatureWithoutUnit]
  return formatter
}()

public let precipitationFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.unitStyle = .short
  formatter.numberFormatter.maximumFractionDigits = 1
  formatter.unitOptions = [.naturalScale]
  return formatter
}()

public let speedFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.unitStyle = .short
  formatter.numberFormatter.maximumFractionDigits = 0
  formatter.unitOptions = [.naturalScale]
  return formatter
}()

public let distanceFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.numberFormatter.maximumFractionDigits = 0
  formatter.unitOptions = [.naturalScale]
  return formatter
}()

public let pressureFormatter: MeasurementFormatter = {
  let formatter = MeasurementFormatter()
  formatter.numberFormatter.maximumFractionDigits = 0
  return formatter
}()

public let humidityFormatter: NumberFormatter = {
  let formatter = NumberFormatter()
  formatter.numberStyle = .percent
  formatter.multiplier = 1.00
  return formatter
}()

public class Formatters {
  public static let shared = Formatters()

  public static let placeholder = "--"

  public let ISO8601: ISO8601DateFormatter = {
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
      .withTimeZone,
    ]
    return formatter
  }()

  public let date: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = "HH:mm"
    return formatter
  }()

  public let number: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = 1
    formatter.roundingMode = .up
    return formatter
  }()

  public let measurement: MeasurementFormatter = {
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .short
    formatter.numberFormatter.maximumFractionDigits = 1
    return formatter
  }()

  public let temperature: MeasurementFormatter = {
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .short
    formatter.numberFormatter.roundingMode = .halfUp
    formatter.numberFormatter.maximumFractionDigits = 0
    return formatter
  }()

  public let distance: MeasurementFormatter = {
    let formatter = MeasurementFormatter()
    formatter.unitOptions = .naturalScale
    formatter.numberFormatter.maximumFractionDigits = 0
    return formatter
  }()

  public let precipitation: MeasurementFormatter = {
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .short
    formatter.numberFormatter.maximumFractionDigits = 1
    formatter.unitOptions = .naturalScale
    return formatter
  }()

  public let direction: MeasurementFormatter = {
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .short
    //    formatter.unitOptions = .providedUnit
    formatter.numberFormatter.maximumFractionDigits = 0
    return formatter
  }()

  public let speed: MeasurementFormatter = {
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .short
    formatter.unitOptions = .naturalScale
    formatter.numberFormatter.maximumFractionDigits = 0
    return formatter
  }()

  public let weekday: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEEE"
    return formatter
  }()
}
