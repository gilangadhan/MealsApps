//
//  CategoryInteractor.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol HomeInteractorProtocol: class {
    func getMeals()
}

class HomeInteractor: HomeInteractorProtocol {
    private var repository: MealRepositorProtocol?

    var presenter: HomePresenterProtocol?

    required init(repository: MealRepositorProtocol) {
        self.repository = repository
    }

    func getMeals() {
        repository?.getMeals { meals in
            self.presenter?.interactor(self, didFetch: meals)
        }
    }
}
