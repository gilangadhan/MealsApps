//
//  HomePresenter.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

protocol HomePresenterProtocol: class {
    func interactor(_ interactor: HomeInteractorProtocol, didFetch object: [Meal])
}

class HomePresenter: ObservableObject {
    @Published var meals: [Meal] = []

    let interactor: HomeInteractorProtocol

    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
    }

    func getMeals() {
        interactor.getMeals()
    }
}

extension HomePresenter: HomePresenterProtocol {
    func interactor(_ interactor: HomeInteractorProtocol, didFetch meals: [Meal]) {
        DispatchQueue.main.async {
            self.meals = meals
        }
    }
}
