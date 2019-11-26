//
//  AddButton.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

class AddButton: UIButton {
  
  weak var delegate: AddButtonDelegate?
  
  init(){
    super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    setUpAddButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setUpAddButton() {
    translatesAutoresizingMaskIntoConstraints = false
    setTitle("+", for: .normal)
    backgroundColor = UIColor.systemIndigo
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
    layer.masksToBounds = false
    layer.shadowRadius = 2.0
    layer.shadowOpacity = 0.5
    layer.cornerRadius = 25
    layer.borderColor = UIColor.black.cgColor
    addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
  }
  
  @objc func  addButtonAction(_ button: UIButton) {
    // Performing segue to insert Name ViewController
    delegate?.performSegueToAddTitle()
  }
}
