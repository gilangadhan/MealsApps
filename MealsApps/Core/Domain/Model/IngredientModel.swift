//
//  IngredientModel.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 21/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

struct IngredientModel: Equatable, Identifiable {
    let id: String
    let title: String
    let mealId: String
}
