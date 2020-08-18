//
//  MealModel.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 14/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

struct MealModel: Equatable, Identifiable {
    let id: String
    let title: String
    let image: String
    var category: String? = ""
    var area: String? = ""
    var instructions: String? = ""
    var tag: String? = ""
    var youtube: String? = ""
    var source: String? = ""
    var ingredient: [String] = []
}
