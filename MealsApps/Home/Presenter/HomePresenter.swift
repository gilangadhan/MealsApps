//
//  HomePresenter.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

protocol HomePresenterProtocol: class {
    func interactor(_ interactor: HomeInteractorProtocol, didFetch object: Result<[Meal], Error>)
}

class HomePresenter: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false

    let interactor: HomeInteractorProtocol

    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
    }

    func getMeals() {
        loadingState = true
        interactor.getMeals()
    }
}

extension HomePresenter: HomePresenterProtocol {
    func interactor(_ interactor: HomeInteractorProtocol, didFetch result: Result<[Meal], Error>) {
        switch result {
        case .success(let meals):
            DispatchQueue.main.async {
                self.loadingState = false
                self.meals = meals
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.loadingState = false
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
