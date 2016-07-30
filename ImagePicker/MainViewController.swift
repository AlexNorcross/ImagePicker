//
//  MainViewController.swift
//  ImagePicker
//
//  Created by Alexandra Norcross on 6/8/16.
//  Copyright © 2016 Alexandra Norcross. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, PickerImageViewDelegate {
  
  //MARK: Properties
  
  private var imageViewMain: PickerImageView!
  private var constraintImageDimensions: (width: NSLayoutConstraint, height: NSLayoutConstraint)?
  private var constraintImagePosition: (x: NSLayoutConstraint, y: NSLayoutConstraint)?
  
  
  //MARK: View Controllers
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    updateConstraints(true)
  }
  
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    
    updateConstraints(false)
  }
  
  override func loadView() {
    
    let rootView = UIView(frame: UIScreen.mainScreen().bounds)
    rootView.backgroundColor = UIColor.whiteColor()
    
    imageViewMain = PickerImageView()
    imageViewMain.delegate = self
    imageViewMain.contentMode = UIViewContentMode.ScaleAspectFit
    
    imageViewMain.translatesAutoresizingMaskIntoConstraints = false
    rootView.addSubview(imageViewMain)
    
    self.view = rootView
  }
  
  
  //MARK: Picker Image Delegate
  
  func showImagePickerController(imagePickerController: UIImagePickerController) {
    self.presentViewController(imagePickerController, animated: true, completion: nil)
  }
  
  func showAlertController(imagePickerMenuController: UIAlertController) {
    self.presentViewController(imagePickerMenuController, animated: true, completion: nil)
  }
  
  
  //MARK: Constraints
  
  private func updateConstraints(isLoading: Bool) {
    
    let isPortrait = MyConstraint.isPortrait(isLoading)
    let lengthImageSide: CGFloat = isPortrait ? 150 : 250
    
    //dimensions
    if constraintImageDimensions != nil {
      constraintImageDimensions!.width.constant = lengthImageSide
      constraintImageDimensions!.height.constant = lengthImageSide
      
    } else {
      
      let constraintWidth = NSLayoutConstraint(item: imageViewMain, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: lengthImageSide)
      let constraintHeight = NSLayoutConstraint(item: imageViewMain, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: lengthImageSide)
      
      constraintImageDimensions = (constraintWidth, constraintHeight)
      
      imageViewMain.addConstraints([constraintWidth, constraintHeight])
    }
    
    //position
    if constraintImagePosition == nil {
      
      let constraintHorizontal = NSLayoutConstraint(item: imageViewMain, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
      let constraintVertical = NSLayoutConstraint(item: imageViewMain, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0)
      
      constraintImagePosition = (constraintHorizontal, constraintVertical)
      
      self.view.addConstraints([constraintHorizontal, constraintVertical])
    }
  }
}