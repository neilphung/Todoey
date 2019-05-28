//
//  Item.swift
//  Todoey
//
//  Created by NeilPhung194 on 5/27/19.
//  Copyright © 2019 NeilPhung194. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title = ""
    @objc dynamic var done = false
    @objc dynamic var dataCreated : Date?
    
    var parenrCategory = LinkingObjects(fromType: Category.self, property: "items")
}
