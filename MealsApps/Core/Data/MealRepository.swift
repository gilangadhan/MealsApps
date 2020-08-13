//
//  MealsRepository.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol MealRepositorProtocol {
    func getMeals(result: @escaping (Result<[Meal], Error>) -> Void)
}

class MealRepository: MealRepositorProtocol {
    private var meals: [Meal] = []

    var remote: RemoteDataSourceProtocol?
    var locale: LocaleDataSourceProtocol?

    required init(locale: LocaleDataSourceProtocol, remote: RemoteDataSourceProtocol) {
        self.locale = locale
        self.remote = remote
    }

    func getMeals(result: @escaping (Result<[Meal], Error>) -> Void) {
        remote?.getMeals { responses in
            switch responses {
            case .success(let meals):
                for meal in meals {
                    if let id = meal.id, let title = meal.title, let image = meal.image, let description = meal.description {
                        self.meals.append(Meal(id: id, title: title, image: image, description: description))
                        result(.success(self.meals))
                    }
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
