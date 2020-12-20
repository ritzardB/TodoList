//
//  Item.swift
//  ToDoIt
//
//  Created by Richard Balabarcon on 9/24/20.
//  Copyright © 2020 Richard Balabarcon. All rights reserved.
//

import Foundation
import RealmSwift

class Item:  Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done:  Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    let notes = List<Notes>()
}
