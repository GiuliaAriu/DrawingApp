//
//  Line.swift
//  DrawingApp
//
//  Created by  Giulia Ariu  on 19/10/2019.
//  Copyright © 2019  Giulia Ariu . All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class Line : Object {
  
  dynamic var  id: String = UUID().uuidString
  dynamic var strokeWidth: Float = 0
  dynamic var color: String = "black"
  dynamic var points = List<Point>()
  
  override static func primaryKey() -> String? {
      return "id"
  }
}

