//
//  CandleStack.swift
//
//
//  Created by Cristian Díaz on 24.02.21.
//

import KyberCommon
import SwiftUI

struct CandleStack: View {

  let values: ClosedRange<Double>
  let extremes: ClosedRange<Double>

  let containerHeight: CGFloat
  let maxHeight: CGFloat

  var body: some View {
    VStack(spacing: 0) {
      switch (values.lowerBound.sign, values.upperBound.sign) {
      //MARK:- (+, +)
      case (.plus, .plus):
        let topHeight = extremes.upperBound - values.upperBound
        let valueHeight = values.upperBound - values.lowerBound
        let distanceToZeroHeight = values.lowerBound
        let bottomHeight = extremes.lowerBound - values.lowerBound

        //MARK: Top
        Spacer()
          .proportionalFrame(
            height: CGFloat(topHeight),
            containerHeight: containerHeight,
            maxHeight: maxHeight
          )
        //MARK: Value
        Rectangle()
          .opacity(0.8)
          .proportionalFrame(
            height: CGFloat(valueHeight),
            containerHeight: containerHeight,
            maxHeight: maxHeight
          )
        //MARK: Distance to zero
        Rectangle()
          .proportionalFrame(
            height: CGFloat(distanceToZeroHeight),
            containerHeight: containerHeight,
            maxHeight: maxHeight
          )
        //MARK: Bottom
        Spacer()
          .proportionalFrame(
            height: CGFloat(max(0, bottomHeight)),
            containerHeight: containerHeight,
            maxHeight: maxHeight
          )

      //MARK:- (-, -)
      case (.minus, .minus):
        let valueHeight = values.lowerBound.magnitude - values.upperBound.magnitude
        let distanceToZeroHeight = values.upperBound.magnitude
        let bottomHeight = extremes.lowerBound.magnitude - (valueHeight + distanceToZeroHeight)
        let topHeight = extremes.upperBound.magnitude + values.upperBound.magnitude

        //MARK: Top
        Spacer()
          .proportionalFrame(
            height: CGFloat(topHeight),
            containerHeight: containerHeight,
            maxHeight: maxHeight
          )
        //MARK: Distance to zero
        Rectangle()
          .proportionalFrame(
            height: CGFloat(distanceToZeroHeight),
            containerHeight: containerHeight,
            maxHeight: maxHeight
          )
        //MARK: Value
        Rectangle()
          .opacity(0.8)
          .proportionalFrame(
            height: CGFloat(valueHeight),
            containerHeight: containerHeight,
            maxHeight: maxHeight
          )
        //MARK: Bottom
        Spacer()
          .proportionalFrame(
            height: CGFloat(bottomHeight),
            containerHeight: containerHeight,
            maxHeight: maxHeight
          )

      //MARK:- (-, +)
      case (.minus, .plus):
        let topHeight = extremes.upperBound - values.upperBound
        let valueHeight = values.upperBound - values.lowerBound.magnitude
        let bottomHeight = extremes.lowerBound.magnitude - values.lowerBound.magnitude

        VStack(spacing: 0) {
          //MARK: Top
          Spacer()
            .proportionalFrame(
              height: CGFloat(topHeight),
              containerHeight: containerHeight,
              maxHeight: maxHeight
            )
          //MARK: Value
          Rectangle()
            .opacity(0.8)
            .proportionalFrame(
              height: CGFloat(valueHeight),
              containerHeight: containerHeight,
              maxHeight: maxHeight
            )
          //MARK: Bottom
          Spacer()
            .proportionalFrame(
              height: CGFloat(bottomHeight),
              containerHeight: containerHeight,
              maxHeight: maxHeight
            )
        }

      case (.plus, .minus):
        fatalError()
      }
    }
  }
}
