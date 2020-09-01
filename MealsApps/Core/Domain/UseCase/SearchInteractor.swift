//
//  SearchInteractor.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 31/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol SearchUseCase {

  func searchMeal(by title: String, completion: @escaping (Result<[MealModel], Error>) -> Void)

}

class SearchInteractor: SearchUseCase {

  private let repository: MealRepositoryProtocol

  required init(repository: MealRepositoryProtocol) {
    self.repository = repository
  }

  func searchMeal(
    by title: String,
    completion: @escaping (Result<[MealModel], Error>) -> Void
  ) {
    repository.searchMeal(by: title) { result in
      completion(result)
    }
  }

}
