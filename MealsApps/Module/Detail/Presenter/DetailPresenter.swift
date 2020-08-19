//
//  DetailPresenter.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 13/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

protocol DetailPresenterProtocol: class {
    func interactor(_ interactor: DetailInteractorProtocol, didFetch object: Result<[MealModel], Error>)
}

class DetailPresenter: ObservableObject {
    @Published var meals: [MealModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    private let router = DetailRouter()
    
    let interactor: DetailInteractorProtocol
    
    init(interactor: DetailInteractorProtocol) {
        self.interactor = interactor
    }
    
    func getMealsByTitle(title: String) {
        loadingState = true
        interactor.getMealsByTitle(title: title)
    }
    
    func linkBuilder<Content: View>(
        for meal: MealModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
        destination: router.makeMealView(for: meal)) { content() }
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func interactor(_ interactor: DetailInteractorProtocol, didFetch result: Result<[MealModel], Error>) {
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
