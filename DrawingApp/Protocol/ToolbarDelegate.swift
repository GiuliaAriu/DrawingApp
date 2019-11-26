//
//  ToolbarDelegate.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 19/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//
import UIKit

protocol ToolbarDelegate : class {
  var isErasing : Bool { get set }
  func changeStrokeColor(color: UIColor)
}
