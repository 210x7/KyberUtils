//
//  TemperaturePlotView.swift
//
//
//  Created by Cristian Díaz on 26.01.21.
//

import SwiftUI
import KyberCommon

struct TemperaturePlotView: View {
  
  let data: [TemperatureData]
  let selectedIndex: Int
  let containerSize: CGSize
  
  private let minTemperature: Measurement<UnitTemperature>
  private let maxTemperature: Measurement<UnitTemperature>
  
  private let base: Double
  private let columnWidth: CGFloat
  
  private let minTemperatureColumnHeight: CGFloat
  private let maxTemperatureColumnHeight: CGFloat
  
  internal init(data: [TemperatureData], selectedIndex: Int, containerSize: CGSize) {
    self.data = data
    self.selectedIndex = selectedIndex
    self.containerSize = containerSize
    
    guard let minTemperature = data.compactMap(\.measurement).min() else { fatalError("Temperature range requires minimum") }
    self.minTemperature = minTemperature
    
    guard let maxTemperature = data.compactMap(\.measurement).max() else { fatalError("Temperature range requires maximum") }
    self.maxTemperature = maxTemperature
    
    self.base = minTemperature.value.magnitude + maxTemperature.value.magnitude
    self.columnWidth = containerSize.width / CGFloat(data.count)
    
    self.maxTemperatureColumnHeight = ruleOfThree(
      base: base,
      extreme: Double(containerSize.height),
      given: maxTemperature.value.magnitude
    )
    
    self.minTemperatureColumnHeight = ruleOfThree(
      base: base,
      extreme: Double(containerSize.height),
      given: minTemperature.value.magnitude
    )
  }
  
  private func height(value: Double) -> CGFloat {
    let isPositive = value.sign == .plus
    return ruleOfThree(
      base: base,
      extreme: Double(containerSize.height),
      given: isPositive
        ? value + max(0, minTemperature.value)
        : -value - min(0, maxTemperature.value)
    )
  }
  
  private func offset(value: Double, height: CGFloat) -> CGFloat {
    switch (minTemperature.value.sign, maxTemperature.value.sign) {
    case (.plus, .plus):
      return .zero
      
    case (.minus, .minus):
      return height - maxTemperatureColumnHeight - minTemperatureColumnHeight
      
    case (.minus, .plus):
      let temperatureDifferenceColumnHeight = maxTemperatureColumnHeight - minTemperatureColumnHeight
      switch (value.sign, temperatureDifferenceColumnHeight.sign) {
      case (.minus, .minus):
        return height + temperatureDifferenceColumnHeight
        
      case (.minus, .plus):
        return height
        
      case (.plus, .minus):
        return temperatureDifferenceColumnHeight
        
      case (.plus, .plus):
        return .zero
      }
      
    default:
      fatalError("Invalid Temperature Scale")
    }
  }
  
  var body: some View {
    HStack(alignment: .bottom, spacing: 0) {
      ForEach(data, id: \.date) { data in
        if let measurement = data.measurement {
          let isPositive = measurement.value.sign == .plus
          
          let height = height(value: measurement.value)
          let offset = offset(value: measurement.value, height: height)
          
          Rectangle()
            .fill(
              isPositive
                ? Color.pink
                : Color("AlmostDowny", bundle: .module)
            )
            .frame(
              width: columnWidth,
              height: height
            )
            .offset(y: offset)
        }
        else {
          Spacer()
            .frame(width: columnWidth, height: columnWidth)
        }
      }
    }
  }
}




























//    VStack(alignment: .leading, spacing: 0) {
//      Text("max: ") + Text(maxTemperature, formatter: Formatters.shared.temperature)
//        .font(.caption)
//
//      Divider()

//
//      Divider()
//      Text("min: ") + Text(minTemperature, formatter: Formatters.shared.temperature).font(.caption)
//    }


//  func color(for index: Int) -> Color {
//    #if os(iOS)
//    return (index == selectedIndex) ? Color.orange : Color(.systemBackground)
//    #else
//    return Color(.systemPink)
//    #endif
//  }



// let isPositive = measurement.value.sign == .plus
// let dataPointHeight: CGFloat = ruleOfThree(
//   base: base,
//   extreme: extreme,
//   given: isPositive
//     ? measurement.value + max(0, minTemperature.value)
//     : -measurement.value - min(0, maxTemperature.value)
// )

// let heightAndOffset = heightAndOffset(
//   value: measurement.value,
//   containerHeight: containerHeight
// )




// //MARK: Over 0
// HStack(alignment: .bottom, spacing: 0) {
//   ForEach(data, id: \.date) { data in
//     if let measurement = data.measurement {
//       if measurement.value > 0 {
//         Rectangle()
//           .fill(Color.pink)
//           .frame(
//             width: columnWidth,
//             height: ruleOfThree(
//               base: differenceMinMax,
//               extreme: extreme,
//               given: measurement.value
//             )
//           )
//       } else {
//         Rectangle().frame(width: columnWidth, height:0)
//       }
//
//     } else {
//       Circle().frame(width: columnWidth, height: columnWidth)
//     }
//   }
// }
//
// //MARK: Below 0
// HStack(alignment: .top, spacing: 0) {
//   ForEach(data, id: \.date) { data in
//     if let measurement = data.measurement {
//       if measurement.value <= 0 {
//         Rectangle()
//           .fill(Color.pink).colorInvert()
//           .frame(
//             width: columnWidth,
//             height: ruleOfThree(
//               base: differenceMinMax,
//               extreme: extreme,
//               given: -measurement.value
//             )
//           )
//       }
//       else { Rectangle().frame(width: columnWidth, height: 0) }
//     }
//     else { Circle().frame(width: columnWidth, height: 0) }
//   }
// }
//
//
//padding([.top, .bottom])

//        VStack(alignment: .leading, spacing: 0) {
//
//          HStack(spacing: 0) {
//            ForEach(data, id: \.date) { data in
//              let components = Calendar.current.dateComponents([.hour], from: (data.date))
//              if components.hour == 0 {
//                Divider().frame(width: columnWidth)
//              }
//              else {
//                Divider().frame(width: columnWidth, height: 0)
//              }
//            }
//          }
//         .frame(height: geometry.size.height)
//
//        }
//      }
//      .drawingGroup()
//      .frame(height: geometry.size.height)
//    }


//              .onAppear { containerHeight = Double(geometry.size.height) }
//              .overlay(
//                VStack {
//                  if let minTemperatureColumnHeight = minTemperatureColumnHeight,
//                     let maxTemperatureColumnHeight = maxTemperatureColumnHeight {
//                    Text("containerHeight: \(containerHeight)")
//                    Text("base: \(base)")
//                    Divider()
//                    HStack {
//                      VStack {
//                        Text("minTemperature: \(minTemperature.value)")
//                        Text("minTemperatureColumnHeight: \(minTemperatureColumnHeight)")
//                      }
//                      Divider()
//                      VStack {
//                        Text("maxTemperature: \(maxTemperature.value)")
//                        Text("maxTemperatureColumnHeight: \(maxTemperatureColumnHeight)")
//                      }
//                    }
//                  }
//                }
//                .padding()
//                .font(.caption)
//                .border(Color.blue)
//              )
