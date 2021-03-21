//
//  NowView.swift
//
//
//  Created by Cristian Díaz on 19.02.21.
//

import ComposableArchitecture
import KyberAstro
import KyberCommon
import KyberGeo
import SwiftUI

public struct NowView: View {
  public init(now: WeatherDataPoint) {
    self.now = now
  }

  let now: WeatherDataPoint
  let columns: [GridItem] = [GridItem(.adaptive(minimum: 180, maximum: 360), spacing: 8)]

  public var body: some View {
      //MARK: Weather Code
      HStack {
        if let weatherCodeImage = now.weatherCodeImage {
          weatherCodeImage
            .boxed()
            .frame(height: 77)
        }

        VStack(alignment: .leading) {
          if let temperature = now.temperature {
            Text(temperature, formatter: Formatters.shared.temperature)
              .font(.largeTitle)
              .fixedSize()
          }
          Text(now.weatherCodeDescription ?? "--")
            .font(.subheadline).bold()
        }
        
        Spacer()
      }
      .padding(8)

    LazyVGrid(columns: columns, alignment: .leading) {
      VStack {
        //MARK: Precipitation
        if let precipitation = now.precipitation {
          GroupBox(
            label: Label("Precipitation", systemImage: "drop.fill").foregroundColor(
              Color(.controlTextColor))
          ) {
            HStack {
              VStack(alignment: .leading) {
                Text("amount").font(.caption).foregroundColor(.secondary)
                Text(precipitation, formatter: Formatters.shared.precipitation)
              }
              Spacer()
            }
          }
        }

        //MARK: Wind Direction
        if let windDirection = now.windDirection,
          let windDirectionDescription = cardinalDirection(for: windDirection.value),
          let windSpeed = now.windSpeed
        {
          GroupBox(
            label: Label("Wind", systemImage: "wind").foregroundColor(Color(.controlTextColor))
          ) {
            HStack {
              VStack(alignment: .leading, spacing: 2) {
                Text("speed").font(.caption).foregroundColor(.secondary)
                Text(windSpeed, formatter: Formatters.shared.speed)
              }

              Divider().frame(maxHeight: 33)

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
        }

        //MARK: Visibility
        if let visibility = now.visibility {
          GroupBox(
            label: Label("Visibility", systemImage: "eye").foregroundColor(Color(.controlTextColor))
          ) {
            HStack {
              VStack(alignment: .leading) {
                Text("distance").font(.caption).foregroundColor(.secondary)
                Text(visibility, formatter: Formatters.shared.distance)
              }
              Spacer()
            }
          }
        }
      }
      //MARK: Pressure/Humidity
      if let pressure = now.pressure,
        let humidty = now.humidty
      {
        CombinedGauges(
          pressure: pressure,
          humidity: humidty
        )
      }

    }
  }
}

struct CombinedGauges: View {
  let pressure: Measurement<UnitPressure>
  let humidity: Int

  var body: some View {
    GroupBox(
      label: Label("Pressure & Humidity", systemImage: "barometer").foregroundColor(
        Color(.controlTextColor))
    ) {
      ZStack(alignment: .bottom) {
        Barometer(currentValue: pressure.value)

        Hygrometer(currentValue: humidity)
          .frame(maxWidth: 44)
          .padding(8)
      }
      .drawingGroup()
    }
  }
}
