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
    
    let usecase: MealsUseCase
    
    init(usecase: MealsUseCase, meal: MealModel) {
        self.usecase = usecase
        self.meal = meal
    }
    
    func getMealById(id: String) {
        loadingState = true
        usecase.getMealById(id: id) { result in
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
