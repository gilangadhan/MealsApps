//
//  MealsInteractor.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 19/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol MealsUseCase {
    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
    func getMealsByTitle(title: String, completion: @escaping (Result<[MealModel], Error>) -> Void)
    func getMealById(id: String, completion: @escaping (Result<MealModel, Error>) -> Void)
}

class MealsInteractor: MealsUseCase {
    private let repository: MealRepositoryProtocol

    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }

    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        repository.getCategories { result in
            completion(result)
        }
    }

    func getMealsByTitle(title: String, completion: @escaping (Result<[MealModel], Error>) -> Void) {
        repository.getMealsByTitle(title: title) { result in
            completion(result)
        }
    }

    func getMealById(id: String, completion: @escaping (Result<MealModel, Error>) -> Void) {
        repository.getMealById(id: id) { result in
            completion(result)
        }
    }
}
