//
//  MealPresenter.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 14/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol MealPresenterProtocol: class {
    func interactor(_ interactor: MealInteractorProtocol, didFetch object: Result<MealModel, Error>)
}

class MealPresenter: ObservableObject {
    @Published var meal: MealModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false

    let interactor: MealInteractorProtocol

    init(interactor: MealInteractorProtocol, meal: MealModel) {
        self.interactor = interactor
        self.meal = meal
    }

    func getMealById(id: String) {
        loadingState = true
        interactor.getMealById(id: id)
    }
}

extension MealPresenter: MealPresenterProtocol {
    func interactor(_ interactor: MealInteractorProtocol, didFetch result: Result<MealModel, Error>) {
        switch result {
        case .success(let meal):
            DispatchQueue.main.async {
                self.loadingState = false
                self.meal = meal
                print(meal)
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.loadingState = false
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
