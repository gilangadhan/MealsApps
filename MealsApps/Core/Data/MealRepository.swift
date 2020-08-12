//
//  MealsRepository.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol MealRepositorProtocol {
    func getMeals(completion: @escaping ([Meal]) -> Void)
}

class MealRepository: MealRepositorProtocol {
    private var meals: [Meal] = []

    var remote: RemoteDataSourceProtocol?
    var locale: LocaleDataSourceProtocol?

    required init(locale: LocaleDataSourceProtocol, remote: RemoteDataSourceProtocol) {
        self.locale = locale
        self.remote = remote
    }

    func getMeals(completion: @escaping ([Meal]) -> Void) {
        remote?.getMeals { responses in
            for meal in responses {
                if let id = meal.id, let title = meal.title, let image = meal.image, let description = meal.description {
                    self.meals.append(Meal(id: id, title: title, image: image, description: description))
                    completion(self.meals)
                }
            }
        }
    }
}
