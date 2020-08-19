//
//  DetailPresenter.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 13/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

class DetailPresenter: ObservableObject {
    @Published var meals: [MealModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    private let router = DetailRouter()
    
    let usecase: MealsUseCase
    
    init(usecase: MealsUseCase) {
        self.usecase = usecase
    }
    
    func getMealsByTitle(title: String) {
        loadingState = true
        usecase.getMealsByTitle(title: title) { result in
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
    
    func linkBuilder<Content: View>(
        for meal: MealModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
        destination: router.makeMealView(for: meal)) { content() }
    }
}
