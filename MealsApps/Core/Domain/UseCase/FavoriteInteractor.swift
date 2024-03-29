//
//  FavoriteInteractor.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 24/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation
import Combine

protocol FavoriteUseCase {

  func getFavoriteMeals() -> AnyPublisher<[MealModel], Error>

}

class FavoriteInteractor: FavoriteUseCase {

  private let repository: MealRepositoryProtocol

  required init(repository: MealRepositoryProtocol) {
    self.repository = repository
  }

  func getFavoriteMeals() -> AnyPublisher<[MealModel], Error> {
    return repository.getFavoriteMeals()
  }

}
