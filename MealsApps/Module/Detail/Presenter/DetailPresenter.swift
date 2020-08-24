//
//  DetailPresenter.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 13/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

class DetailPresenter: ObservableObject {
    private let router = DetailRouter()
    private let interactor: DetailUseCase

    @Published var meals: [MealModel] = []
    @Published var category: CategoryModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(interactor: DetailUseCase) {
        self.interactor = interactor
        category = interactor.getCategory()
    }
    
    func getMealsByCategory() {
        loadingState = true
        interactor.getMealsByCategory { result in
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
