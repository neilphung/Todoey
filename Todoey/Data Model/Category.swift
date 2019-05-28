//
//  Category.swift
//  Todoey
//
//  Created by NeilPhung194 on 5/27/19.
//  Copyright © 2019 NeilPhung194. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name = ""
    let items = List<Item>()
}
