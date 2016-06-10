//
//  MainViewController.swift
//  ImagePicker
//
//  Created by Alexandra Norcross on 6/8/16.
//  Copyright © 2016 Alexandra Norcross. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, PickerImageViewDelegate {
  
  //MARK: Constants
  
  private let lengthImageSide: CGFloat = 150
  
  
  //MARK: Properties
  
  private var imageViewMain: PickerImageView!
  
  
  //MARK: View Controllers
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func loadView() {
    
    let rootView = UIView(frame: UIScreen.mainScreen().bounds)
    rootView.backgroundColor = UIColor.whiteColor()
    
    imageViewMain = PickerImageView()
    imageViewMain.delegate = self
    imageViewMain.contentMode = UIViewContentMode.ScaleAspectFit
    
    imageViewMain.translatesAutoresizingMaskIntoConstraints = false
    rootView.addSubview(imageViewMain)
    
    
    let horizontalImage = NSLayoutConstraint(item: imageViewMain, attribute: .CenterX, relatedBy: .Equal, toItem: rootView, attribute: .CenterX, multiplier: 1, constant: 0)
    let verticalImage = NSLayoutConstraint(item: imageViewMain, attribute: .CenterY, relatedBy: .Equal, toItem: rootView, attribute: .CenterY, multiplier: 1, constant: 0)
    rootView.addConstraints([horizontalImage, verticalImage])
    
    let widthImage = NSLayoutConstraint(item: imageViewMain, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: lengthImageSide)
    let heightImage = NSLayoutConstraint(item: imageViewMain, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: lengthImageSide)
    imageViewMain.addConstraints([widthImage, heightImage])
    
    self.view = rootView
  }
  
  
  //MARK: Picker Image Delegate
  
  func showImagePickerController(imagePickerController: UIImagePickerController) {
    self.presentViewController(imagePickerController, animated: true, completion: nil)
  }
  
  func showAlertController(imagePickerMenuController: UIAlertController) {
    self.presentViewController(imagePickerMenuController, animated: true, completion: nil)
  }
}