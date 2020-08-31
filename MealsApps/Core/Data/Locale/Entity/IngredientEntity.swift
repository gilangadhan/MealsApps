//
//  IngredientEntity.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 21/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation
import RealmSwift

class IngredientEntity: Object {

  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var idMeal: String = ""
  
}
