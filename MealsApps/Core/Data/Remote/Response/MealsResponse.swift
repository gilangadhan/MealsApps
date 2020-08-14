//
//  MealsResponse.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 14/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

struct MealsResponse: Decodable {
    let meals: [MealResponse]
}

struct MealResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case title = "strMeal"
        case image = "strMealThumb"
    }

    let id: String?
    let title: String?
    let image: String?
}
