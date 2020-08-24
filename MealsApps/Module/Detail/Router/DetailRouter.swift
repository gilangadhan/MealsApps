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
        let interactor = Injection.init().provideMeal(meal: meal)
        let presenter = MealPresenter(interactor: interactor)
        return MealView(presenter: presenter)
    }
}
