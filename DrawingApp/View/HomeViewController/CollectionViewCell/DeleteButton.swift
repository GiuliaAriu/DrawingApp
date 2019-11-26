//
//  DeleteButton.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 24/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

class DeleteButton: UIButton {

  weak var delegate: DeleteButtonDelegate?
 
  init(){
    super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    setUpDeleteButton()
    setUpShadow()
  }
  
  fileprivate func setUpDeleteButton() {
    
    isHidden = true
    imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
    
    layer.cornerRadius = 15
    translatesAutoresizingMaskIntoConstraints = false
    setImage(UIImage(named: "Delete"), for: .normal)
    addTarget(self, action: #selector(deleteButtonPressed(_:)), for: .touchUpInside)
    backgroundColor = .white
  }
  
  fileprivate func setUpShadow() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
    layer.masksToBounds = false
    layer.shadowRadius = 2.0
    layer.shadowOpacity = 0.5
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func deleteButtonPressed(_ : UIButton){
    delegate?.deleteButtonPressed()
  }
}
