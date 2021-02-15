//
//  TimeZoneOffsetView.swift
//  SturmfreiCommon
//
//  Created by Cristian Díaz on 01.10.20.
//

import CoreLocation
import KyberGeo
import SwiftUI

public struct TimeZoneOffsetView: View {
  public init(placemark: CLPlacemark?) {
    self.placemark = placemark
  }
  
  let placemark: CLPlacemark?
  
  public var body: some View {
    if let offsetDescription = placemark?.offsetDescription() {
      Text(offsetDescription)
        .font(.caption2)
        // .foregroundColor(.secondary)
        .padding(2)
        .background(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.secondary)
          // .stroke(Color(.tertiaryLabel))
        )
    }
    else {
      Spacer()
    }
  }
}
