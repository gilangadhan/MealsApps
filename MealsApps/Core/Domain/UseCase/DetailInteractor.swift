//
//  DetailInteractor.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 24/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol DetailUseCase {
    func getMealsByCategory(completion: @escaping (Result<[MealModel], Error>) -> Void)
    func getCategory() -> CategoryModel
}

class DetailInteractor: DetailUseCase {
    private let repository: MealRepositoryProtocol
    private let category: CategoryModel

    required init(repository: MealRepositoryProtocol, category: CategoryModel) {
        self.repository = repository
         self.category = category
    }

    func getMealsByCategory(completion: @escaping (Result<[MealModel], Error>) -> Void) {
        repository.getMealsByCategory(category: category.title) { result in
            completion(result)
        }
    }

    func getCategory() -> CategoryModel {
        return category
    }
}
