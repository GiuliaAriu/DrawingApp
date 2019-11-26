//
//  HomeViewController.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
  
  //MARK:- Cell ID
  let cellId = "cellID"
  let firstCellId = "firstCellID"
  var draws : Results<Draw>?
  
  //MARK:- Collection View
  let collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
    collectionView.register(AddButtonCollectionViewCell.self, forCellWithReuseIdentifier: "firstCellID")
    collectionView.backgroundColor = .clear
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 10 ,bottom: 0, right: 10)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    return collectionView
  }()
  
  //MARK:- LogoLabel
  let logoLabel : UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.text = "Your Drawings"
    return label
  }()
  
  //MARK:- Edit Mode Active
  var editModeActive : Bool = false
  
  //MARK:- Edit Button
  let editButton = EditButton()
  
  override func viewWillAppear(_ animated: Bool) {
    loadDraws()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    setUpLogoLabel()
    setUpCollectionView()
    setUpEditButton()
  }
  
  //MARK:- Setup Collection View
  fileprivate func setUpCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([ collectionView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 40),
                                  collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                                  collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                                  collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  //MARK:- Setup Logo Label
  fileprivate func setUpLogoLabel() {
    view.addSubview(logoLabel)
    NSLayoutConstraint.activate([logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                 logoLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
                                 logoLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
                                 logoLabel.heightAnchor.constraint(equalToConstant: 50)
      
    ])
  }
  
  //MARK:- Setup EditButton
  fileprivate func setUpEditButton() {
    view.addSubview(editButton)
    editButton.delegate = self
    NSLayoutConstraint.activate([editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                 editButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
                                 editButton.widthAnchor.constraint(equalToConstant: 80),
                                 editButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
}


extension HomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if let draws = draws {
      if draws.count > 0 {
        // +1 because the first cell will be the one with the Add Button
        return draws.count + 1
      }
    }
    
    //Only the cell with the Add Button
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    // First cell will show the add button cell
    if indexPath.row == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: firstCellId, for: indexPath) as! AddButtonCollectionViewCell
      cell.addButton.delegate = self
      return cell
      
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCollectionViewCell
      
      // Assigning the corrispondent draw
      if let draws = draws {
        // -1 because the first cell will be the one with the Add Button
        cell.draw = draws[indexPath.row - 1]
      }
      
      cell.delegate = self
      //Enabling/Disabling EditMode (delete button visible or not)
      cell.editModeEnabled = editModeActive
      
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: (collectionView.frame.width/2) - 20, height: (collectionView.frame.height/2 - 30))
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell {
      let selectedDraw = cell.draw
      performSegue(withIdentifier: "toDrawingViewController", sender: selectedDraw)
    }
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "toDrawingViewController" {
      let drawingViewController = segue.destination as! DrawingViewController
      
      // If pressed on a cell it will send the cell's DrawModel
      // Otherwise it will create, save and send a new DrawModel
      if let selectedDraw = sender as? Draw {
        drawingViewController.draw = selectedDraw
      } else {
        let drawingViewController = segue.destination as! DrawingViewController
        let newDraw = Draw(date: Date())
        addNewDraw(newDraw: newDraw)
        
        drawingViewController.draw = newDraw
        
      }
    }
  }
}

//MARK:- Edit Button Delegate Methods
extension HomeViewController: EditButtonDelegate {
  func editButtonPressed(isSelected: Bool) {
    editModeActive = isSelected
    collectionView.reloadData()
  }
}


//MARK:- Add Button Delegate Methods
extension HomeViewController: AddButtonDelegate {
  func performSegueToAddTitle() {
    // Performing Segue to Insert TitleViewController
    performSegue(withIdentifier: "toDrawingViewController", sender: nil)
  }
}

//MARK:- HomeCollectionViewCell Delegate Methods
extension HomeViewController: HomeCollectionViewCellDelegate {
  func deleteDraw(_ draw: Draw) {
    deleteSelectedDraw(draw: draw)
  }
}

//MARK:- Persistence with Realm
extension HomeViewController {
  
  func deleteSelectedDraw(draw: Draw){
    
    if let draws = draws {
      do {
        try draws.realm?.write {
          
          draws.realm?.delete(draw)
        }
      }
      catch {
        fatalError(error.localizedDescription)
      }
    }
    
    collectionView.reloadData()
  }
  
  func loadDraws() {
    
    let realmService = try! Realm()
    
    // To Filter mapNames
    draws = realmService.objects(Draw.self).sorted(byKeyPath: "date", ascending: false)
  }
  
  
  func addNewDraw(newDraw: Draw) {
    
    let realmService = try! Realm()
    do {
      try realmService.write {
        realmService.add(newDraw)
      }
    } catch  {
      print(error)
    }
  }
}
