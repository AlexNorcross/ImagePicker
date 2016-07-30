//
//  MyConstraint.swift
//  ImagePicker
//
//  Created by Alexandra Norcross on 7/29/16.
//  Copyright © 2016 Alexandra Norcross. All rights reserved.
//

import UIKit

struct MyConstraint {
  
  static func isPortrait(isLoading: Bool) -> Bool {
    
    if isLoading {
      return UIApplication.sharedApplication().statusBarOrientation == .Portrait
    } else {
      return UIDevice.currentDevice().orientation.isPortrait
    }
  }
}