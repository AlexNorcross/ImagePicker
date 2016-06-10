//
//  Alerts.swift
//  ImagePicker
//
//  Created by Alexandra Norcross on 6/10/16.
//  Copyright © 2016 Alexandra Norcross. All rights reserved.
//

import UIKit

struct alertControllerGoToSettings {
  
  var title: String
  var message: String
  
  var alertController: UIAlertController {
    
    let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    
    let actionSettings = UIAlertAction(title: "Settings", style: .Default) { (action) -> Void in
      if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
        UIApplication.sharedApplication().openURL(appSettings)
      }
    }
    controller.addAction(actionSettings)
    
    controller.addAction(UIAlertAction(title: "Later", style: .Default, handler: nil))
    
    return controller
  }
}

struct alertControllerError {
  
  var title: String
  var message: String
  
  var alertController: UIAlertController {
    
    let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    
    controller.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    
    return controller
  }
}