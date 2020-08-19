//
//  HomeRouter.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 12/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

class HomeRouter {
    func makeDetailView(for category: CategoryModel) -> some View {
        let usecase = Injection.init().provideMeals()
        let presenter = DetailPresenter(usecase: usecase)
        return DetailView(presenter: presenter, category: category)
    }
}
