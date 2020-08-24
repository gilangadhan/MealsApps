//
//  MealPresenter.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 14/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

class MealPresenter: ObservableObject {
    @Published var meal: MealModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    let mealUseCase: MealUseCase
    
    init(mealUseCase: MealUseCase) {
        self.mealUseCase = mealUseCase
        meal = mealUseCase.getMeal()
    }
    
    func getMealById() {
        loadingState = true
        mealUseCase.getMealById { result in
            switch result {
            case .success(let meal):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.meal = meal
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func updateFavoriteMeal() {
        mealUseCase.updateFavoriteMeal { result in
            switch result {
            case .success(let meal):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.meal = meal
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
