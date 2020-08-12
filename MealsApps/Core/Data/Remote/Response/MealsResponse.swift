//
//  CategoriesResponse.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

struct MealsResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case meals = "categories"
    }
    let meals: [MealResponse]
}

struct MealResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case title = "strCategory"
        case image = "strCategoryThumb"
        case description = "strCategoryDescription"
    }

    let id: String?
    let title: String?
    let image: String?
    let description: String?
}
