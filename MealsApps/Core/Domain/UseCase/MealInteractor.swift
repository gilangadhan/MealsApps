//
//  MealInteractor.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 24/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol MealUseCase {

  func getMeal(completion: @escaping (Result<MealModel, Error>) -> Void)
  func getMeal() -> MealModel
  func updateFavoriteMeal(completion: @escaping (Result<MealModel, Error>) -> Void)

}

class MealInteractor: MealUseCase {

  private let repository: MealRepositoryProtocol
  private let meal: MealModel

  required init(
    repository: MealRepositoryProtocol,
    meal: MealModel
  ) {
    self.repository = repository
    self.meal = meal
  }

  func getMeal(
    completion: @escaping (Result<MealModel, Error>) -> Void
  ) {
    repository.getMeal(by: meal.id) { result in
      completion(result)
    }
  }

  func getMeal() -> MealModel {
    return meal
  }

  func updateFavoriteMeal(
    completion: @escaping (Result<MealModel, Error>) -> Void
  ) {
    repository.updateFavoriteMeal(by: meal.id) { result in
      completion(result)
    }
  }

}
