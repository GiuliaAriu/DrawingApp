//
//  HomeCollectionViewCell.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
  
  weak var delegate: HomeCollectionViewCellDelegate?
  
  //MARK:- Configure Using Draw Model
  var draw: Draw? {
    didSet {
      
      let dateFormatter = DateFormatter()
      
      // Creating the Date String
      // If the Draw is created today then show only hour, otherwise full timestamp
      let todayDate = Date()
      let calendar = Calendar.current
      let todayComponents = calendar.dateComponents([.year, .month, .day], from: todayDate)
      let loadedDateComponents = calendar.dateComponents([.year, .month, .day], from: draw!.date)
      
      let todayYear = todayComponents.year
      let todayMonth = todayComponents.month
      let todayDay = todayComponents.day
      let loadedDateYear = loadedDateComponents.year
      let loadedDateMonth = loadedDateComponents.month
      let loadedDateDay = loadedDateComponents.day
      
      if todayDay == loadedDateDay &&
        todayMonth == loadedDateMonth &&
        todayYear == loadedDateYear {
        dateFormatter.dateFormat = "h:mm a"
      } else {
        dateFormatter.dateFormat = "MM-dd-yyyy  h:mm a"
        
      }
      let dateString = dateFormatter.string(from: draw!.date)
      dateLabel.text = "Last modify:\n\(dateString)"
      drawPreviewImage.image = UIImage(data: draw!.image)
    }
  }
  
  let drawPreviewImage : UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.shadowColor = UIColor.black.cgColor
    imageView.layer.shadowOffset = CGSize(width: 1.0, height: 5.0)
    imageView.layer.masksToBounds = false
    imageView.layer.shadowRadius = 2.0
    imageView.layer.shadowOpacity = 0.3
    imageView.layer.borderWidth = 0.3
    imageView.layer.borderColor = UIColor.lightGray.cgColor
    return imageView
  }()
  
  let dateLabel : UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 2
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    return label
  }()
  
  let deleteButton = DeleteButton()
   
  var editModeEnabled : Bool = false {
     willSet (newValue) {
       deleteButton.isHidden = !newValue
     }
   }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  fileprivate func setupCell() {
    
    setUpDeleteButton()
    setUpDataLabel()
    setUpDrawPreviewImage()
    
  }
  
  fileprivate func setUpDeleteButton() {
    deleteButton.delegate = self
    contentView.addSubview(deleteButton)
    NSLayoutConstraint.activate([deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                                 deleteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
                                 deleteButton.widthAnchor.constraint(equalToConstant: 30),
                                 deleteButton.heightAnchor.constraint(equalToConstant: 30)
    
    ])
  }
  
  fileprivate func setUpDrawPreviewImage() {
    contentView.addSubview(drawPreviewImage)
    NSLayoutConstraint.activate([drawPreviewImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                                 drawPreviewImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                                 drawPreviewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                                 drawPreviewImage.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -20)
    ])
  }
  
  
  fileprivate func setUpDataLabel() {
    contentView.addSubview(dateLabel)
    NSLayoutConstraint.activate([
      dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
      dateLabel.rightAnchor.constraint(equalTo: deleteButton.leftAnchor, constant: -5),
      dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
      
    ])
  }
}


extension HomeCollectionViewCell: DeleteButtonDelegate {
  func deleteButtonPressed() {
    if let draw = draw {
      delegate?.deleteDraw(draw)
    }
  }
}
