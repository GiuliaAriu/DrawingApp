//
//  Toolbar.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 19/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

class Toolbar: UIView, ColorButtonDelegate{
  
  weak var delegate: ToolbarDelegate?
  
  //MARK:- CollectionView for colors
  let collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 10
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(ColorButtonCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
    collectionView.backgroundColor = .clear
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  //MARK:- Color Button Array
  var colorButtons = [ColorButton]()
  
  //MARK:- Pencil Button
  let pencilButton = UIButton()
  
  init(){
    super.init(frame: .zero)
    
    setUpDrawingToolBar()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setUpDrawingToolBar() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .white
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    //SetUp Appearance
    createPencilButton()
    createButtons()
    createCollectionView()
    
  }
  
  fileprivate func createButtons() {
    let blackButton = ColorButton(color: .black, delegate: self)
    let redButton = ColorButton(color: .systemRed, delegate: self)
    let greenButton = ColorButton(color: .systemGreen, delegate: self)
    let blueButton = ColorButton(color: .systemBlue, delegate: self)
    let yellowButton = ColorButton(color: .systemYellow, delegate: self)
    let brownButton = ColorButton(color: .brown, delegate: self)
    let purpleButton = ColorButton(color: .systemPurple, delegate: self)
    let grayButton = ColorButton(color: .systemGray, delegate: self)
    let magentaButton = ColorButton(color: .systemPink, delegate: self)
    let orangeButton = ColorButton(color: .systemOrange, delegate: self)
    
    populateColorButtonArray(blackButton,
                             redButton,
                             orangeButton,
                             yellowButton,
                             greenButton,
                             blueButton,
                             purpleButton,
                             magentaButton,
                             brownButton,
                             grayButton
                             )
    
    // First Button Selected
    blackButton.colorButtonAction(blackButton)
  }
  
  
  fileprivate func populateColorButtonArray(_ buttons: ColorButton...) {
    colorButtons.append(contentsOf: buttons)
    collectionView.reloadData()
  }
  
  //MARK:- Pencil Button
  fileprivate func createPencilButton() {
    pencilButton.setImage(UIImage(named: "pencil"), for: .normal)
    pencilButton.setImage(UIImage(named: "eraser"), for: .selected)
    
    addSubview(pencilButton)
    pencilButton.addTarget(self, action: #selector(pencilTapped(button:)), for: .touchUpInside)
    pencilButton.translatesAutoresizingMaskIntoConstraints = false
    pencilButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40).isActive = true
    pencilButton.topAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive = true
    pencilButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 100).isActive = true
    pencilButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
  }
  
  //MARK:- ColorCollectionView
  fileprivate func createCollectionView() {
    addSubview(collectionView)
    collectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    collectionView.leftAnchor.constraint(equalTo: pencilButton.rightAnchor, constant: 20).isActive = true
    collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
  }
  
  //MARK:- PENCIL BUTTON ACTION
  @objc func pencilTapped(button: UIButton) {
    button.isSelected = !button.isSelected
    
    //ERASER
    if button.isSelected {
      delegate?.isErasing = true
    }
      //PENCIL
    else {
      delegate?.isErasing = false
    }
  }
  
  //MARK:- ColorButtonDelegate Methods
  func colorButtonPressed(color: UIColor) {
    // Looping through the DrawingToolBarView to delete every borderWidth
    
    colorButtons.forEach { (colorButton) in
      colorButton.isPressed = false
    }
    
    
    // Changing Stroke and TextColor based on the button pressed background color
    delegate?.changeStrokeColor(color: color)
  }
}




extension Toolbar : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return colorButtons.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! ColorButtonCollectionViewCell
    cell.colorButton = colorButtons[indexPath.row]
    return cell
  }
  
}
