//
//  Point.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019  Giulia Ariu . All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Point : Object {
  
  dynamic var  id: String = UUID().uuidString
  dynamic var  x: Float = 0
  dynamic var  y: Float = 0
 
  override static func primaryKey() -> String? {
      return "id"
  }
}
