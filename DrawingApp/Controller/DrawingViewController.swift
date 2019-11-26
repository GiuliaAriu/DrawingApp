//
//  ViewController.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 19/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit
import RealmSwift

class DrawingViewController: UIViewController {
  
  let toolBar = Toolbar()
  let canvas = Canvas()
  var draw : Draw? {
    // If a draw is sent by HomeViewController then send it
    didSet {
      canvas.draw = draw
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpToolBar()
    setUpCanvas()
   
  }
  //MARK:- SETUP CANVAS
  private func setUpCanvas() {
    view.addSubview(canvas)
    canvas.delegate = self
    NSLayoutConstraint.activate([canvas.topAnchor.constraint(equalTo: view.topAnchor),
                                canvas.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                                canvas.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                                canvas.bottomAnchor.constraint(equalTo: toolBar.topAnchor)
    ])
    
  }
  
  //MARK:- SETUP TOOLBAR
  private func setUpToolBar() {
    toolBar.delegate = canvas
    view.addSubview(toolBar)
    NSLayoutConstraint.activate([toolBar.heightAnchor.constraint(equalToConstant: 150),
                                 toolBar.leftAnchor.constraint(equalTo: view.leftAnchor),
                                 toolBar.rightAnchor.constraint(equalTo: view.rightAnchor),
                                 toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
  
  
}

//MARK:- CanvasDelegate Methods
extension DrawingViewController: CanvasDelegate {
  
  //Performing Segue to Home View Controller
  func performSegueToHomeViewController() {
    performSegue(withIdentifier: "toHomeViewController", sender: nil)
  }
}

