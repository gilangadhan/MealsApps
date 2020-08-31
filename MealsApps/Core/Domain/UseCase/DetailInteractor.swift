//
//  DetailInteractor.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 24/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol DetailUseCase {

  func getMeals(completion: @escaping (Result<[MealModel], Error>) -> Void)
  func getCategory() -> CategoryModel

}

class DetailInteractor: DetailUseCase {

  private let repository: MealRepositoryProtocol
  private let category: CategoryModel
  
  required init(
    repository: MealRepositoryProtocol,
    category: CategoryModel
  ) {
    self.repository = repository
    self.category = category
  }
  
  func getMeals(
    completion: @escaping (Result<[MealModel], Error>) -> Void
  ) {
    repository.getMeals(by: category.title) { result in
      completion(result)
    }
  }
  
  func getCategory() -> CategoryModel {
    return category
  }

}
