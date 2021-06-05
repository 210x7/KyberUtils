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
  let columns: [GridItem] = [.init(.adaptive(minimum: 180, maximum: 360))]

  public var body: some View {
    VStack(alignment: .leading, spacing: 32) {
      //MARK: - Weather Code
      HStack {
        if let weatherCodeImage = now.weatherCodeImage {
          weatherCodeImage
            .boxed()
            .frame(height: 77)
        }

        VStack(alignment: .leading) {
          Group {
            if let temperature = now.temperature {
              Text(temperature, formatter: temperatureFormatter)
            } else {
              Text("--")
            }
          }
          .font(.largeTitle)

          Text(now.weatherCodeDescription ?? "--")
            .font(.subheadline)
        }
      }
      .padding([.leading, .top])

      LazyVGrid(columns: columns, alignment: .leading) {
        VStack(alignment: .leading, spacing: 16) {
          //MARK: Precipitation
          if let precipitation = now.precipitation {
            GroupBox(
              label: Label("Precipitation", systemImage: "drop.fill"),
              content: {
                Label(
                  title: { Text(precipitation, formatter: precipitationFormatter) },
                  icon: { Text("amount") }
                )
                .labelStyle(MeasurementLabelStyle())
              }
            )
            .groupBoxStyle(MeasurementGroupBoxStyle(labelColor: Color(.controlTextColor)))
          }

          //MARK: Wind Direction
          if let windDirection = now.windDirection,
            let windDirectionDescription = cardinalDirection(for: windDirection.value),
            let windSpeed = now.windSpeed
          {
            GroupBox(
              label: Label("Wind", systemImage: "wind"),
              content: {
                HStack(alignment: .top) {
                  Label(
                    title: { Text(windSpeed, formatter: speedFormatter) },
                    icon: { Text("speed") }
                  )
                  .labelStyle(MeasurementLabelStyle())

                  //Divider().frame(maxHeight: 22)
                  Text("/")

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
                }
              }
            )
            .groupBoxStyle(MeasurementGroupBoxStyle(labelColor: Color(.controlTextColor)))
          }

          //MARK: Visibility
          if let visibility = now.visibility {
            GroupBox(
              label: Label("Visibility", systemImage: "eye"),
              content: {
                Label(
                  title: { Text(visibility, formatter: distanceFormatter) },
                  icon: { Text("distance") }
                )
                .labelStyle(MeasurementLabelStyle())
              }
            )
            .groupBoxStyle(MeasurementGroupBoxStyle(labelColor: Color(.controlTextColor)))
          }
        }

        //MARK: - Pressure/Humidity
        if let pressure = now.pressure,
          let humidity = now.humidity
        {
          CombinedGauges(
            pressure: pressure,
            humidity: humidity
          )
          .frame(minWidth: 200)
        }
      }
    }

  }
}

struct CombinedGauges: View {
  let pressure: Measurement<UnitPressure>
  let humidity: Int

  var body: some View {
    //FIXME: couldnt make `GeometryReader` work properly with "Hygrometer"
    Barometer(
      currentValue: pressure,
      humidity: humidity
    )
  }
}

//MARK: - MeasurementLabelStyle

struct MeasurementLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    VStack(alignment: .leading) {
      configuration.title
      configuration.icon
        .font(.footnote)
        .foregroundColor(.secondary)

    }
  }
}

//MARK: - MeasurementGroupBoxStyle

struct MeasurementGroupBoxStyle: GroupBoxStyle {
  let labelColor: Color

  func makeBody(configuration: Configuration) -> some View {
    VStack(alignment: .leading, spacing: 4) {
      configuration.label
        .font(.callout)
        .foregroundColor(labelColor)
      Divider()

      configuration.content
        .font(.title2)

    }
  }
}

#if DEBUG
  struct NowView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        ScrollView {
          LazyVStack(pinnedViews: .sectionHeaders) {
            Section(
              header: Label("Now", systemImage: "calendar"),
              content: {
                NowView(
                  now: .init(
                    timestamp: Date(),
                    sunset: Date().addingTimeInterval(60),
                    sunrise: Date().addingTimeInterval(60 * 60),
                    weatherCodeImage: Image("clear-day", bundle: .module),
                    weatherCodeDescription: "Sunny",
                    temperature: .init(value: 32, unit: .celsius),
                    precipitation: .init(value: 0.2, unit: .millimeters),
                    windDirection: .init(value: 77, unit: .degrees),
                    windSpeed: .init(value: 38, unit: .kilometersPerHour),
                    visibility: .init(value: 30, unit: .kilometers),
                    pressure: .init(value: 1020, unit: .hectopascals),
                    humidty: 45)
                )
              }
            )
          }
        }
        .background(Color.controlBackground)

        List {
          NowView(
            now: .init(
              timestamp: Date(),
              sunset: Date().addingTimeInterval(60),
              sunrise: Date().addingTimeInterval(60 * 60),
              weatherCodeImage: Image("clear-day", bundle: .module),
              weatherCodeDescription: "Sunny",
              temperature: .init(value: 32, unit: .celsius),
              precipitation: .init(value: 0.2, unit: .millimeters),
              windDirection: .init(value: 77, unit: .degrees),
              windSpeed: .init(value: 38, unit: .kilometersPerHour),
              visibility: .init(value: 30, unit: .kilometers),
              pressure: .init(value: 1020, unit: .hectopascals),
              humidty: 45)
          )
        }
        .environment(\.colorScheme, .dark)
      }
      .previewLayout(.fixed(width: 300, height: 700))
    }
  }
#endif
