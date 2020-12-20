//
//  Category.swift
//  ToDoIt
//
//  Created by Richard Balabarcon on 9/24/20.
//  Copyright © 2020 Richard Balabarcon. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name:  String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
}
