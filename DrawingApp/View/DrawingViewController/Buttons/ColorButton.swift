//
//  ColorButton.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 19/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

class ColorButton: UIButton {

  weak var delegate: ColorButtonDelegate?
  
  // Adding or Removing
  var isPressed : Bool = false {
    didSet (newValue) {
      if newValue {
        layer.borderWidth = 5
      } else {
        layer.borderWidth = 0
      }
    }
  }
  
  init(color: UIColor, delegate: ColorButtonDelegate){
    super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    self.delegate = delegate
    setUpCell(color)
    setUpColorButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setUpColorButton() {
    setUpShadow()
    addTarget(self, action: #selector(colorButtonAction(_:)), for: .touchUpInside)
  }
  
  fileprivate func setUpCell(_ color: UIColor) {
    backgroundColor = color
    layer.borderColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0).cgColor
  }
  
  fileprivate func setUpShadow() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
    layer.masksToBounds = false
    layer.shadowRadius = 2.0
    layer.shadowOpacity = 0.5
    layer.cornerRadius = 25
  }
  
  @objc func colorButtonAction(_ button: UIButton) {
    
    // Adding the Border to the pressed button
    isPressed = true
    
    if let selectedColor = button.backgroundColor {
      delegate?.colorButtonPressed(color: selectedColor)
    }
  }
}
