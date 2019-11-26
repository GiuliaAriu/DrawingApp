//
//  Draw.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019  Giulia Ariu . All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Draw: Object {
  
  dynamic var lines = List<Line>()
  dynamic var id: String = UUID().uuidString
  dynamic var date: Date!
  dynamic var image: Data = Data()
  
  convenience init(date: Date) {
    self.init()
    
    self.date = date
  }
  
  override static func primaryKey() -> String? {
      return "id"
  }
}
