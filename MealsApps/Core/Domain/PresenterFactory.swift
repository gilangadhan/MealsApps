//
//  ViewModelFactory.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 19/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

enum ViewPresenter {
    case home, detail, meal
}

final class PresenterFactory: NSObject {
    fileprivate let usecase: MealsUseCase

    private override init() {
        self.usecase = Injection.init().provideMeals()
    }
}
