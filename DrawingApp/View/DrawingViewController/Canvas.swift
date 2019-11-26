//
//  Canvas.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 19/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit
import RealmSwift

class Canvas: UIView {
    
    var isErasing: Bool
    var lines = [Line]()
    var strokeColor = UIColor.black
    var strokeWidth: Float = 5
      
    var draw : Draw? {
        didSet {
            lines.append(contentsOf: draw!.lines)
        }
    }
  
    //MARK:- CANVAS DELEGATE
    weak var delegate: CanvasDelegate?

    //MARK:- UNDO BUTTON
    let undoButton = UndoButton()

    //MARK:- BACK BUTTON
    let backButton = BackButton()

    //MARK:- INIT
    init() {
        isErasing = false
        super.init(frame: .zero)
        setUpCanvas()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:- SETUP CANVAS

    fileprivate func setUpCanvas() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white

        //Adding a Top Shadow
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.masksToBounds = false
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.2
        layer.borderColor = UIColor.black.cgColor

        setUpBackButton()
        setUpUndoButton()
    }

  
 
  
    //MARK:- Setup Back Button
    fileprivate func setUpBackButton() {
        addSubview(backButton)
        backButton.delegate = self
        NSLayoutConstraint.activate([backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
                                     backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
                                     backButton.widthAnchor.constraint(equalToConstant: 70),
                                     backButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }


    
    //MARK:- Setup Undo Button
     fileprivate func setUpUndoButton() {
       addSubview(undoButton)
       undoButton.delegate = self
       NSLayoutConstraint.activate([undoButton.widthAnchor.constraint(equalToConstant: 55),
                                    undoButton.heightAnchor.constraint(equalToConstant: 55),
                                    undoButton.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -16),
                                    undoButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor)
       ])
    }
  
    // MARK:- DRAWING
    override func draw(_ rect: CGRect) {
        
        // custom drawing
        super.draw(rect)
        
        if lines.isEmpty {
          undoButton.disabled = true
        } else {
          undoButton.disabled = false
        }
        guard let context = UIGraphicsGetCurrentContext() else { return }

        //Enabling the undo button if there are lines
        undoButton.disabled = lines.isEmpty

        lines.forEach { (line) in
          
          context.setStrokeColor(UIColor.colorFromString(string: line.color).cgColor)
          
          context.setLineWidth(CGFloat(line.strokeWidth))
          
          context.setLineCap(.round)
          
          for (i, p) in line.points.enumerated() {
            if i == 0 {
              context.move(to: CGPoint(x: CGFloat(p.x), y: CGFloat(p.y)))
            } else {
              context.addLine(to: CGPoint(x: CGFloat(p.x), y: CGFloat(p.y)))
            }
          }
          context.strokePath()
          
          // TextDidEndedEditing will be triggered and the View saved
          self.endEditing(true)
        }
    }
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        let line = Line(value: [])
        line.points = List<Point>()

        if isErasing {
          line.color = UIColor.stringFromColor(color: UIColor.white)
          line.strokeWidth = strokeWidth * 5
        } else {
          line.color = UIColor.stringFromColor(color: strokeColor)
          line.strokeWidth = strokeWidth
        }

        lines.append(line)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: self) else { return }

        guard let lastLine = lines.popLast() else { return }

        let newPoint = Point()
        newPoint.x = Float(point.x)
        newPoint.y = Float(point.y)
        lastLine.points.append(newPoint)

        lines.append(lastLine)

        setNeedsDisplay()
        
    }

}



//MARK:- UNDOBUTTONDELEGATE METHODS
extension Canvas : UndoButtonDelegate {
  func undoButtonPressed() {
    lines.removeLast(lines.count)
    setNeedsDisplay()
  }
}

//MARK:- TOOLBAR DELEGATE METHOD
extension Canvas: ToolbarDelegate {
  func changeStrokeColor(color: UIColor) {
    strokeColor = color
  }
}

//MARK:- BACKBUTTONDELEGATE METHOD
extension Canvas: BackButtonDelegate {
  
  //MARK:- SAVING DRAW and PERFORMING SEGUE
  func backButtonPressed() {
    do {
      try draw?.realm?.write {
        if let draw = draw {
          
          // Deleting all from draw lines array just before assigning the new linesArray
          draw.lines.removeAll()
          draw.lines.append(objectsIn: lines)
          
          //Last Modified Date
          draw.date = Date()
          
          backButton.isHidden = true
          undoButton.isHidden = true
          draw.image = self.takeScreenshot().pngData()!
          
          delegate?.performSegueToHomeViewController()
        }
      }
    } catch  {
      print(error)
    }
  }
}

