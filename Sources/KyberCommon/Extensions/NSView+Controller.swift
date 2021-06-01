//
//  NSView+Controller.swift
//
//
//  Created by Cristian Díaz on 12.05.21.
//

import AppKit

extension NSView {
  public func findSplitViewController() -> NSSplitViewController? {
    if let nextResponder = self.nextResponder as? NSSplitViewController {
      return nextResponder
    } else if let nextResponder = self.nextResponder as? NSView {
      return nextResponder.findSplitViewController()
    } else {
      return nil
    }
  }
}
