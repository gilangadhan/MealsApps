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

    func provideMeals() -> MealsUseCase {
        let repository = provideRepository()
        return MealsInteractor(repository: repository)
    }
}
