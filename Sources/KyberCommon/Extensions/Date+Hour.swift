//
//  Date+Hour.swift
//  
//
//  Created by Cristian Díaz on 31.01.21.
//

import Foundation

extension Date {
  public var nextHour: Date {
    let calendar = Calendar.current
    let minutes = calendar.component(.minute, from: self)
    let components = DateComponents(hour: 1, minute: -minutes)
    return calendar.date(byAdding: components, to: self) ?? self
  }
}
