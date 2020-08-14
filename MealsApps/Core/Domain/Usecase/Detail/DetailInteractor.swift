//
//  DetailInteractor.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 13/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol DetailInteractorProtocol: class {
    func getMealsByTitle(title: String)
}

class DetailInteractor: DetailInteractorProtocol {
    private let repository: MealRepositorProtocol

    var presenter: DetailPresenterProtocol?

    required init(repository: MealRepositorProtocol) {
        self.repository = repository
    }

    func getMealsByTitle(title: String) {
        repository.getMealsByTitle(title: title) { result in
            self.presenter?.interactor(self, didFetch: result)
        }
    }
}
