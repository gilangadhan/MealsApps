//
//  MealBuilder.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 12/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

final class Injection: NSObject {
  
  private func provideRepository() -> MealRepositoryProtocol {
    let locale: LocaleDataSource = LocaleDataSource.shared()
    let remote: RemoteDataSource = RemoteDataSource.shared()

    return MealRepository.shared(locale: locale, remote: remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }

  func provideDetail(category: CategoryModel) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, category: category)
  }

  func provideMeal(meal: MealModel) -> MealUseCase {
    let repository = provideRepository()
    return MealInteractor(repository: repository, meal: meal)
  }

  func provideFavorite() -> FavoriteUseCase {
    let repository = provideRepository()
    return FavoriteInteractor(repository: repository)
  }

  func provideSearch() -> SearchUseCase {
    let repository = provideRepository()
    return SearchInteractor(repository: repository)
  }

}
