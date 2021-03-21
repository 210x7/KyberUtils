//
//  Tomorrow.swift
//  
//
//  Created by Cristian Díaz on 20.02.21.
//

import SwiftUI
import KyberCommon
import KyberGeo

public struct TomorrowView: View {
  public init(data tomorrow: [WeatherDataPoint]) {
    self.tomorrow = tomorrow
  }
  
  let tomorrow: [WeatherDataPoint]
  
  public var body: some View {
    ScrollView(.horizontal) {
      HStack(alignment: .top) {
        ForEach(tomorrow, id: \.timestamp) { weatherPoint in
          VStack {
            Text(weatherPoint.timestamp, style: .time).font(.caption).foregroundColor(.secondary)
            
            if let weatherCodeImage = weatherPoint.weatherCodeImage {
              weatherCodeImage
                .boxed()
                .frame(height: 33)
            }
            
            Group {
              if let temperature = weatherPoint.temperature {
                Text(
                  temperature.forcingPositiveZero(),
                  formatter: Formatters.shared.temperature
                )
              } else {
                Text(Formatters.placeholder)
              }
            }
            .font(.title2)
            
            if let precipitation = weatherPoint.precipitation {
              Text(precipitation, formatter: Formatters.shared.precipitation)
                .font(.subheadline)
            }
            
            if let windDirection = weatherPoint.windDirection,
               let windSpeed = weatherPoint.windSpeed {
              // As far as METARs are considered, the wind direction gives the direction from which the wind is coming.
              //https://aviation.stackexchange.com/questions/26549/how-is-wind-direction-reported-blowing-from-or-blowing-to
              Image(systemName: "arrow.up.circle")
                .rotationEffect(.degrees(windDirection.value + 180))
                .padding([.top, .bottom], 2)

              Text(windSpeed, formatter: Formatters.shared.speed).font(.footnote)
            }
          }
          .drawingGroup()
          
          Divider()
        }
      }
      .padding(.bottom)
    }.workaroundForVerticalScrollingBugInMacOS()
    .frame(idealHeight: 180)
  }
}
