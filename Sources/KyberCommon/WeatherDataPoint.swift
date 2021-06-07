//
//  WeatherDataPoint.swift
//
//
//  Created by Cristian Díaz on 19.02.21.
//

import SwiftUI

/// Adapter to homogenize values coming from different APIs but presented using similar components
/// (e.g DWD, ClimaCell)
public struct WeatherDataPoint: Equatable {
  public init(
    timestamp: Date,
    sunset: Date?,
    sunrise: Date?,
    weatherCodeImage: Image?,
    weatherCodeDescription: String?,
    temperature: Measurement<UnitTemperature>?,
    precipitation: Measurement<UnitLength>?,
    windDirection: Measurement<UnitAngle>?,
    windSpeed: Measurement<UnitSpeed>?,
    visibility: Measurement<UnitLength>?,
    pressure: Measurement<UnitPressure>?,
    humidty: Int?
  ) {
    self.timestamp = timestamp
    self.sunset = sunset
    self.sunrise = sunrise
    self.weatherCodeImage = weatherCodeImage
    self.weatherCodeDescription = weatherCodeDescription
    self.temperature = temperature
    self.precipitation = precipitation
    self.windDirection = windDirection
    self.windSpeed = windSpeed
    self.visibility = visibility
    self.pressure = pressure
    self.humidity = humidty
  }

  public let timestamp: Date
  public let sunset: Date?
  public let sunrise: Date?
  public let weatherCodeImage: Image?
  public let weatherCodeDescription: String?
  public let temperature: Measurement<UnitTemperature>?
  public let precipitation: Measurement<UnitLength>?
  public let windDirection: Measurement<UnitAngle>?
  public let windSpeed: Measurement<UnitSpeed>?
  public let visibility: Measurement<UnitLength>?
  public let pressure: Measurement<UnitPressure>?
  public let humidity: Int?
}
