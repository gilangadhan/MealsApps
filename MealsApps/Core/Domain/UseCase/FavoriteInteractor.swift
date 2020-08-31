//
//  FavoriteInteractor.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 24/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol FavoriteUseCase {

  func getFavoriteMeals(completion: @escaping (Result<[MealModel], Error>) -> Void)

}

class FavoriteInteractor: FavoriteUseCase {

  private let repository: MealRepositoryProtocol
  
  required init(repository: MealRepositoryProtocol) {
    self.repository = repository
  }
  
  func getFavoriteMeals(
    completion: @escaping (Result<[MealModel], Error>) -> Void
  ) {
    repository.getFavoriteMeals { result in
      completion(result)
    }
  }

}
