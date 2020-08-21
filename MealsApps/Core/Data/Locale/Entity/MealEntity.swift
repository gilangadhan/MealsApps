//
//  MealEntity.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 21/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation
import RealmSwift

class MealEntity: Object {
    @objc dynamic var id: String? = ""
    @objc dynamic var title: String? = ""
    @objc dynamic var image: String? = ""
    @objc dynamic var category = ""
    @objc dynamic var area = ""
    @objc dynamic var instructions = ""
    @objc dynamic var tag = ""
    @objc dynamic var youtube = ""
    @objc dynamic var source = ""
    //@objc dynamic var ingredient: [String] = []
    @objc dynamic var favorite = false
}
