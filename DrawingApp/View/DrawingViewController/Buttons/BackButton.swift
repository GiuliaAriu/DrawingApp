//
//  BackButton.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

class BackButton : UIButton {
  
  weak var delegate: BackButtonDelegate?
  
  init() {
    super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    setUpBackButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setUpBackButton() {
    setUpShadow()
//    backgroundColor = .white
    translatesAutoresizingMaskIntoConstraints = false
    isHidden = false
    imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    layer.cornerRadius = 25
    setImage(UIImage(named: "PurpleBack"), for: .normal)
    addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
  }
  
  
  
  fileprivate func setUpShadow() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
    layer.masksToBounds = false
    layer.shadowRadius = 2.0
    layer.shadowOpacity = 0.5
  }
  
  @objc func backButtonPressed(_ button: UIButton) {
    delegate?.backButtonPressed()
  }
}
