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
        let usecase = Injection.init().provideMeals()
        let presenter = MealPresenter(usecase: usecase, meal: meal)
        return MealView(presenter: presenter)
    }
}
