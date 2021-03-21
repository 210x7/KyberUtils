//
//  MapCalloutView.swift
//  tdotwiz
//
//  Created by Ahmed El-Khuffash on 2020-05-31.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation
#if os(macOS)
import AppKit
#else
import UIKit
#endif

import SwiftUI

/**
 A custom callout view to be be passed as an MKMarkerAnnotationView, where you can use a SwiftUI View as it's base.
 */
public class MapCalloutView: NSView {
  
  //create the UIHostingController we need. For now just adding a generic UI
  let body:NSHostingController<AnyView> = NSHostingController(rootView: AnyView(Text("...")) )
  
  /**
   An initializer for the callout. You must pass it in your SwiftUI view as the rootView property, wrapped with AnyView. e.g.
   MapCalloutView(rootView: AnyView(YourCustomView))
   
   Obviously you can pass in any properties to your custom view.
   */
  public init(rootView: AnyView) {
    super.init(frame: CGRect.zero)
    body.rootView = AnyView(rootView)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  /**
   Ensures the callout bubble resizes according to the size of the SwiftUI view that's passed in.
   */
  private func setupView() {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    //pass in your SwiftUI View as the rootView to the body UIHostingController
    //body.rootView = Text("Hello World * 2")
    body.view.translatesAutoresizingMaskIntoConstraints = false
    body.view.frame = bounds

    //add the subview to the map callout
    addSubview(body.view)
    
    NSLayoutConstraint.activate([
      body.view.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      body.view.bottomAnchor.constraint(equalTo: bottomAnchor),
      body.view.leftAnchor.constraint(equalTo: leftAnchor),
      body.view.rightAnchor.constraint(equalTo: rightAnchor)
    ])
    
    // sizeToFit()
    
  }
}
