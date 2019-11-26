//
//  EditButton.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 24/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

class EditButton: UIButton {

    weak var delegate: EditButtonDelegate?
    
    init(){
      super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
      
      setUpAddButton()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpAddButton() {
      translatesAutoresizingMaskIntoConstraints = false
      setTitle("Edit", for: .normal)
      setTitle("Done", for: .selected)
      backgroundColor = UIColor.systemIndigo
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
      layer.masksToBounds = false
      layer.shadowRadius = 2.0
      layer.shadowOpacity = 0.5
      layer.cornerRadius = 15
      layer.borderColor = UIColor.black.cgColor
      addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
    }
    
    @objc func  editButtonAction(_ button: UIButton) {
      isSelected = !isSelected
      
      delegate?.editButtonPressed(isSelected: self.isSelected)
    }

}
