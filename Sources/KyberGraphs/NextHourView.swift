//
//  NextHourView.swift
//  
//
//  Created by Cristian Díaz on 19.02.21.
//

import SwiftUI
import KyberCommon
import KyberGeo

func comparisonIcon<T: Comparable>(previous: T, current: T) -> Image {
  if previous > current {
    return Image(systemName: "arrow.down")
  } else if previous < current {
    return Image(systemName: "arrow.up")
  } else {
    return Image(systemName: "equal")
  }
}

public struct NextHourView: View {
  public init(now: WeatherDataPoint?, nextHour: WeatherDataPoint) {
    self.now = now
    self.nextHour = nextHour
  }
  
  let now: WeatherDataPoint?
  let nextHour: WeatherDataPoint
  
  public var body: some View {
    VStack(alignment: .leading) {
      if
        let temperature = nextHour.temperature,
        let condition = nextHour.weatherCodeDescription,
        let weatherCodeImage = nextHour.weatherCodeImage,
        let precipitation = nextHour.precipitation,
        let windDirection = nextHour.windDirection,
        let windDirectionDescription = cardinalDirection(for: windDirection.value),
        let windSpeed = nextHour.windSpeed,
        let visibility = nextHour.visibility
      {
        VStack(alignment: .leading) {
          HStack {
            weatherCodeImage
              .boxed()
              .frame(height: 22)
            
            if let previousTemperature = now?.temperature {
              comparisonIcon(
                previous: previousTemperature,
                current: temperature
              )
              .foregroundColor(.secondary)
              Divider().frame(maxHeight: 33)
            }
            
            if let temperature = nextHour.temperature {
              Text(
                temperature.forcingPositiveZero(),
                formatter: Formatters.shared.temperature
              )
              .font(.title2)
            }
            
            Text(condition).font(.subheadline)
          }
          .padding(.leading, 8)
          
          //MARK: Precipitation
          GroupBox {
            HStack {
              if let previousPrecipitation = now?.precipitation {
                comparisonIcon(
                  previous: previousPrecipitation,
                  current: precipitation
                )
                .foregroundColor(.secondary)
                Divider().frame(maxHeight: 33)
              }
              Image(systemName: "drop.fill")
              VStack(alignment: .leading) {
                Text("amount").font(.caption).foregroundColor(.secondary)
                Text(precipitation, formatter: Formatters.shared.precipitation)
              }
              
              Spacer()
            }
          }
          
          //MARK: Wind
          GroupBox {
            HStack {
              if let previousWindSpeed = now?.windSpeed {
                comparisonIcon(
                  previous: previousWindSpeed,
                  current: windSpeed
                )
                .foregroundColor(.secondary)
                Divider().frame(maxHeight: 33)
              }
              
              Image(systemName: "wind")
              VStack(alignment: .leading, spacing: 2) {
                Text("speed").font(.caption).foregroundColor(.secondary)
                Text(windSpeed, formatter: Formatters.shared.speed)
              }
              
              Divider()
                .frame(maxHeight: 33)
              
              VStack(alignment: .leading, spacing: 2) {
                Text("direction").font(.caption).foregroundColor(.secondary)
                HStack(spacing: 4) {
                  Text(windDirectionDescription)
                  // As far as METARs are considered, the wind direction gives the direction from which the wind is coming.
                  //https://aviation.stackexchange.com/questions/26549/how-is-wind-direction-reported-blowing-from-or-blowing-to
                  Image(systemName: "arrow.up.circle")
                    .rotationEffect(.degrees(windDirection.value + 180))
                    .font(.title3)
                }
              }
              Spacer()
            }
          }
          
          //MARK: Visibility
          GroupBox {
            HStack {
              if let previousVisibility = now?.visibility {
                comparisonIcon(
                  previous: previousVisibility,
                  current: visibility
                )
                .foregroundColor(.secondary)
                Divider().frame(maxHeight: 33)
              }
              Image(systemName: "eye")
              VStack(alignment: .leading) {
                Text("distance").font(.caption).foregroundColor(.secondary)
                Text(visibility, formatter: Formatters.shared.distance)
              }
              Spacer()
            }
          }
          
          //MARK: Pressure/Humidity
          GroupBox {
            VStack(spacing: 0) {
              if let pressure = nextHour.pressure {
                HStack {
                  if let previousPressure = now?.pressure {
                    comparisonIcon(
                      previous: previousPressure,
                      current: pressure
                    )
                    .foregroundColor(.secondary)
                    Divider().frame(height: 33)
                  }
                  Image(systemName: "barometer")
                  Text(pressure, formatter: Formatters.shared.measurement).padding([.top, .bottom], 4)
                  Spacer()
                }
              }
              
              if let humidity = nextHour.humidty  {
                HStack {
                  if let previousHumidity = now?.humidty {
                    comparisonIcon(
                      previous: previousHumidity,
                      current: humidity
                    )
                    .foregroundColor(.secondary)
                    Divider().frame(height: 33)
                  }
                  //Image(systemName: "barometer")
                  Text("\(humidity)%").padding([.top, .bottom], 4)//TODO: make proper formatter
                  Spacer()
                }
              }
            }
          }
        
          //if let humidity = nextHour.humidity {
          //  Text("\(humidity)")
          //}
          //
          //if let pressure = nextHour.pressure,
          //   let humidity = nextHour.humidity {
          //  VStack {
          //    Spacer()
          //    Gauges(
          //      pressure: pressure,
          //      humidity: humidity
          //    )
          //  }
          //}
          
        }
      }
    }
  }
}
