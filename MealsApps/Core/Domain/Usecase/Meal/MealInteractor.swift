//
//  MealInteractor.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 14/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol MealInteractorProtocol: class {
    func getMealById(id: String)
}

class MealInteractor: MealInteractorProtocol {
    private let repository: MealRepositorProtocol

    var presenter: MealPresenterProtocol?

    required init(repository: MealRepositorProtocol) {
        self.repository = repository
    }

    func getMealById(id: String) {
        repository.getMealById(id: id) { result in
            self.presenter?.interactor(self, didFetch: result)
        }
    }
}
