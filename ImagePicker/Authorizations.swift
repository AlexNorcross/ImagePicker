//
//  Authorizations.swift
//  ImagePicker
//
//  Created by Alexandra Norcross on 6/9/16.
//  Copyright © 2016 Alexandra Norcross. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

struct Authorizations {
  
  static func authorizedToAccessCamera() -> Bool {

    var authorized = (AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) == .Authorized)
    if !authorized {

      if !(NSUserDefaults.standardUserDefaults().boolForKey("requestedCameraAuthorization")) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "requestedCameraAuthorization")
        NSUserDefaults.standardUserDefaults().synchronize()
        authorized = true //not authorized yet; but set this to throw iOS request
      }
    }

    return authorized
  }

  static func authorizedToAccessPhotoLibrary() -> Bool {

    var authorized = (PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.Authorized)
    if !authorized {

      if !(NSUserDefaults.standardUserDefaults().boolForKey("requestedPhotoLibraryAuthorization")) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "requestedPhotoLibraryAuthorization")
        NSUserDefaults.standardUserDefaults().synchronize()
        authorized = true //not authorized yet; but set this to throw iOS request
      }
    }
    
    return authorized
  }
}