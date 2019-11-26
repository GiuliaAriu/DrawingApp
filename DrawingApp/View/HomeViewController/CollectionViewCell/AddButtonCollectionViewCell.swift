//
//  AddButtonCollectionViewCell.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 21/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

class AddButtonCollectionViewCell: UICollectionViewCell {
  
  let addButton = AddButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  fileprivate func setupCell() {
    
    setUpAddButton()
  }
  
  //MARK:- Setup Add Button
  fileprivate func setUpAddButton() {
    
    contentView.addSubview(addButton)
    NSLayoutConstraint.activate([addButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                 addButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                 addButton.widthAnchor.constraint(equalToConstant: 50),
                                 addButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
}
