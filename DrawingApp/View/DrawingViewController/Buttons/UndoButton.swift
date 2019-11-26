//
//  UndoButton.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 19/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

class UndoButton : UIButton {
  
  weak var delegate: UndoButtonDelegate?
  
  var disabled = false {
    didSet (newValue) {
      self.isHidden = newValue
      self.isUserInteractionEnabled = !newValue
    }
  }
  
  init() {
    super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    setUpUndoButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setUpShadow() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    layer.masksToBounds = false
    layer.shadowRadius = 2.0
    layer.shadowOpacity = 0.5
  }
  
  fileprivate func setUpUndoButton() {
    
    setUpShadow()
    
//    backgroundColor = .white
    translatesAutoresizingMaskIntoConstraints = false
    isHidden = false
    imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    layer.cornerRadius = 25
    setImage(UIImage(named: "PurpleUndo"), for: .normal)
    addTarget(self, action: #selector(undoButtonPressed(_:)), for: .touchUpInside)
  }
  
  @objc func undoButtonPressed(_ button: UIButton) {
    delegate?.undoButtonPressed()
  }
}
