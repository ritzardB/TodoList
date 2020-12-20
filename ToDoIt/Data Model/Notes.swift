//
//  Notes.swift
//  ToDoIt
//
//  Created by Richard Balabarcon on 9/25/20.
//  Copyright © 2020 Richard Balabarcon. All rights reserved.
//

import Foundation
import RealmSwift

class Notes:  Object {
    
    @objc dynamic var notes : String = ""
    var childItem = LinkingObjects(fromType: Item.self, property: "notes")
}
