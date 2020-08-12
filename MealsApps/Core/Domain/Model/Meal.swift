//
//  Category.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

struct Meal: Equatable, Identifiable {
    let id: String
    let title: String
    let image: String
    let description: String
}
