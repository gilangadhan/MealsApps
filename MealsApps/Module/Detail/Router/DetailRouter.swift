//
//  DetailRouter.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 18/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

class DetailRouter {
    func makeMealView(for meal: MealModel) -> some View {
        let interactor = MealInteractor(repository: MealRepository(locale: LocaleDataSource(), remote: RemoteDataSource()))
        let presenter = MealPresenter(interactor: interactor, meal: meal)
        interactor.presenter = presenter
        return MealView(presenter: presenter)
    }
}
