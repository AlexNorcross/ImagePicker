//
//  PickerImageView.swift
//  ImagePicker
//
//  Created by Alexandra Norcross on 6/8/16.
//  Copyright © 2016 Alexandra Norcross. All rights reserved.
//

import UIKit

protocol PickerImageViewDelegate: class {
  
  func showImagePickerController(imagePickerController: UIImagePickerController)
  func showAlertController(imagePickerMenuController: UIAlertController)
}

class PickerImageView: UIImageView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  //MARK: Constants
  
  private let defaultImageName = "NeedImage"
  
  
  //MARK: Properties
  
  weak var delegate: PickerImageViewDelegate!
  
  var imagePickerController = UIImagePickerController()
  
  
  //MARK: Initializers
  
  init() {
    super.init(frame: CGRectZero)

    self.userInteractionEnabled = true
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.pressedImageView(_:))))
    
    self.image = UIImage(named: defaultImageName)
    
    imagePickerController.delegate = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  //MARK: Selectors
  
  func pressedImageView(sender: UIImageView) {
    
    let cameraIsAvailable = UIImagePickerController.isSourceTypeAvailable(.Camera)
    let photoLibaryIsAvailable = UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
    
    if cameraIsAvailable && !photoLibaryIsAvailable {
      openImageSource(.Camera)

    } else if !cameraIsAvailable && photoLibaryIsAvailable {
      openImageSource(.PhotoLibrary)

    } else if cameraIsAvailable && photoLibaryIsAvailable {
      
      let imagePickerMenu = imagePickerMenuController
      
      if let popoverController = imagePickerMenu.popoverPresentationController {
        popoverController.sourceView = sender
        popoverController.sourceRect = sender.bounds
      }

      delegate.showAlertController(imagePickerMenu)

    } else {
      let errorAlertController = alertControllerError(title: "Oops", message: "A Camera or Photo Library is not available on this device.")
      delegate.showAlertController(errorAlertController.alertController)
    }
  }
  
  
  //MARK: Image Picker Controller Delegate
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

    let selectedImage = info[UIImagePickerControllerEditedImage] as! UIImage
    self.image = selectedImage
    imagePickerController.dismissViewControllerAnimated(true, completion: nil)
  }
  
  
  //MARK: Functionality
  
  private func openImageSource(imageSource: UIImagePickerControllerSourceType) {
    
    var authorized = true
    
    if imageSource == .Camera {
      authorized = Authorizations.authorizedToAccessCamera()
      
    } else if imageSource == .PhotoLibrary {
      authorized = Authorizations.authorizedToAccessPhotoLibrary()
    }
    
    if authorized {
      imagePickerController.sourceType = imageSource
      imagePickerController.allowsEditing = true
      delegate.showImagePickerController(imagePickerController)
    
    } else {
      
      //when debugging, the app will crash when the setting is changed
      
      let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
      var sourceName = "this"
      if imageSource == .Camera {
        sourceName = "Camera"
      } else if imageSource == .PhotoLibrary {
        sourceName = "Photo Library"
      }
      
      let settingsAlertController = alertControllerGoToSettings(title: "Oops", message: "We don't have access to your \(sourceName). Go to your device Settings, then \(appName). Once we have access, you can select an image.")
      delegate.showAlertController(settingsAlertController.alertController)
    }
  }
  
  private var imagePickerMenuController: UIAlertController {
    
    let alertController = UIAlertController(title: "Get Image", message: "Where should we find that image?", preferredStyle: .ActionSheet)
    
    let actionCamera = UIAlertAction(title: "Camera", style: .Default) { [weak self] (pressedCamera) -> Void in
      self?.openImageSource(.Camera)
    }
    alertController.addAction(actionCamera)
    
    let actionPhotoLibrary = UIAlertAction(title: "Photo Library", style: .Default) { [weak self] (pressedPhotoLibrary) -> Void in
      self?.openImageSource(.PhotoLibrary)
    }
    alertController.addAction(actionPhotoLibrary)
    
    let actionCancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    alertController.addAction(actionCancel)
    
    return alertController
  }
}