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
    func getMealById(id: String, result: @escaping (Result<MealModel, Error>) -> Void)
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

    func getMealById(id: String, result: @escaping (Result<MealModel, Error>) -> Void) {
        remote?.getMealById(id: id) { responses in
            switch responses {
            case .success(let meal):
                var mealModel: MealModel

                if let id = meal.id, let title = meal.title, let image = meal.image {
                    mealModel = MealModel(id: id,
                                          title: title,
                                          image: image,
                                          category: meal.category,
                                          area: meal.area,
                                          instructions: meal.instructions,
                                          tag: meal.tag,
                                          youtube: meal.youtube,
                                          source: meal.source)
                    mealModel.ingredient = self.ingredientToArray(meal: meal)
                    result(.success(mealModel))
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}

extension MealRepository {
    func ingredientToArray(meal: MealResponse) -> [String] {
        var ingredients = [meal.ingredient1, meal.ingredient2, meal.ingredient3, meal.ingredient4,
                           meal.ingredient5, meal.ingredient6, meal.ingredient7, meal.ingredient8,
                           meal.ingredient9, meal.ingredient10, meal.ingredient11, meal.ingredient12,
                           meal.ingredient13, meal.ingredient14, meal.ingredient15, meal.ingredient16,
                           meal.ingredient17, meal.ingredient18, meal.ingredient19, meal.ingredient20]
            .compactMap { $0 }
        ingredients = ingredients.filter({ $0 != ""})
        var measures = [meal.measure1, meal.measure2, meal.measure3, meal.measure4,
                        meal.measure5, meal.measure6, meal.measure7, meal.measure8,
                        meal.measure9, meal.measure10, meal.measure11, meal.measure12,
                        meal.measure13, meal.measure14, meal.measure15, meal.measure16,
                        meal.measure17, meal.measure18, meal.measure19, meal.measure20]
            .compactMap { $0 }
        measures = measures.filter({ $0 != ""})
        let ingredientStrings = zip(ingredients, measures)
            .map { "\($0) \($1)" }
        return ingredientStrings
    }
}
