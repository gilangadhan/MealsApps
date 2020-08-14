//
//  MealsRepository.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol MealRepositorProtocol {
    func getCategories(result: @escaping (Result<[CategoryModel], Error>) -> Void)
    func getMealsByTitle(title: String, result: @escaping (Result<[MealModel], Error>) -> Void)
}

class MealRepository: MealRepositorProtocol {
    var remote: RemoteDataSourceProtocol?
    var locale: LocaleDataSourceProtocol?

    required init(locale: LocaleDataSourceProtocol, remote: RemoteDataSourceProtocol) {
        self.locale = locale
        self.remote = remote
    }

    func getCategories(result: @escaping (Result<[CategoryModel], Error>) -> Void) {
        remote?.getCategories { responses in
            switch responses {
            case .success(let results):
                var categories: [CategoryModel] = []

                for category in results {
                    if let id = category.id, let title = category.title, let image = category.image, let description = category.description {
                        categories.append(CategoryModel(id: id, title: title, image: image, description: description))
                    }
                }
                result(.success(categories))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }

    func getMealsByTitle(title: String, result: @escaping (Result<[MealModel], Error>) -> Void) {
        remote?.getMealsByTitle(title: title) { responses in
            switch responses {
            case .success(let results):
                var meals: [MealModel] = []

                for meal in results {
                    if let id = meal.id, let title = meal.title, let image = meal.image {
                        meals.append(MealModel(id: id, title: title, image: image))
                    }
                }
                result(.success(meals))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
