//
//  ColorButtonCollectionViewCell.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 22/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

class ColorButtonCollectionViewCell: UICollectionViewCell {
  
  var colorButton : ColorButton? {
    didSet {
      setUpAddButton()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  //MARK:- Setup Add Button
  fileprivate func setUpAddButton() {
    
    if let colorButton = colorButton {
      contentView.addSubview(colorButton)
      NSLayoutConstraint.activate([colorButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                   colorButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                   colorButton.widthAnchor.constraint(equalToConstant: 50),
                                   colorButton.heightAnchor.constraint(equalToConstant: 50)
      ])
    }
  }
}
