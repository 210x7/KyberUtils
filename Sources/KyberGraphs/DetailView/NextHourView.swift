//
//  NextHourView.swift
//
//
//  Created by Cristian Díaz on 19.02.21.
//

import KyberCommon
import KyberGeo
import SwiftUI

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
  let columns: [GridItem] = [GridItem(.adaptive(minimum: 180, maximum: 360), spacing: 8)]

  public var body: some View {
    VStack(alignment: .leading) {
      if let temperature = nextHour.temperature,
        let condition = nextHour.weatherCodeDescription,
        let weatherCodeImage = nextHour.weatherCodeImage,
        let precipitation = nextHour.precipitation,
        let windDirection = nextHour.windDirection,
        let windDirectionDescription = cardinalDirection(for: windDirection.value),
        let windSpeed = nextHour.windSpeed,
        let visibility = nextHour.visibility
      {
        //MARK: Weather Code
        HStack {
          weatherCodeImage
            .boxed()
            .frame(height: 22)

          if let temperature = nextHour.temperature {
            Text(temperature, formatter: temperatureFormatter)
              .font(.title2)
          }

          if let previousTemperature = now?.temperature {
            comparisonIcon(
              previous: previousTemperature,
              current: temperature
            )
            .foregroundColor(.secondary)

            Divider().frame(maxHeight: 33)
          }

          Text(condition)

          Spacer()
        }
        .padding(8)

        LazyVGrid(columns: columns, alignment: .leading) {
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
              Label(
                title: { Text(precipitation, formatter: precipitationFormatter) },
                icon: { Text("amount") }
              )
              .labelStyle(MeasurementLabelStyle())

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
              Label(
                title: { Text(windSpeed, formatter: speedFormatter) },
                icon: { Text("speed") }
              )
              .labelStyle(MeasurementLabelStyle())

              Divider()
                .frame(maxHeight: 33)

              Label(
                title: {
                  HStack(spacing: 4) {
                    Text(windDirectionDescription)
                    // As far as METARs are considered, the wind direction gives the direction from which the wind is coming.
                    //https://aviation.stackexchange.com/questions/26549/how-is-wind-direction-reported-blowing-from-or-blowing-to
                    Image(systemName: "arrow.up.circle")
                      .rotationEffect(.degrees(windDirection.value + 180))
                      .font(.title3)
                  }
                },
                icon: { Text("direction") }
              )
              .labelStyle(MeasurementLabelStyle())
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
              Label(
                title: { Text(visibility, formatter: distanceFormatter) },
                icon: { Text("distance") }
              )
              .labelStyle(MeasurementLabelStyle())

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
                  Text(pressure, formatter: pressureFormatter).padding(
                    [.top, .bottom], 4)
                  Spacer()
                }
              }

              if let humidity = nextHour.humidity {
                HStack {
                  if let previousHumidity = now?.humidity {
                    comparisonIcon(
                      previous: previousHumidity,
                      current: humidity
                    )
                    .foregroundColor(.secondary)
                    Divider().frame(height: 33)
                  }

                  Text(humidityFormatter.string(for: humidity) ?? "--")
                    .padding([.top, .bottom], 4)
                  Spacer()
                }
              }
            }
          }
        }
      }
    }
  }
}
