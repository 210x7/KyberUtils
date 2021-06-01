//
//  View+Introspection.swift
//
//
//  Created by Cristian Díaz on 13.05.21.
//

import Foundation
import Introspect
import SwiftUI

extension View {
  public func introspectSplitView(customize: @escaping (NSSplitView) -> Void) -> some View {
    introspect(selector: TargetViewSelector.ancestorOrSiblingContaining, customize: customize)
  }
}
