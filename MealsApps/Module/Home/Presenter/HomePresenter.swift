//
//  HomePresenter.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

class HomePresenter: ObservableObject {
    @Published var categories: [CategoryModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    private let router = HomeRouter()
    
    let usecase: MealsUseCase
    
    init(usecase: MealsUseCase) {
        self.usecase = usecase
    }
    
    func getCategories() {
        loadingState = true
        usecase.getCategories { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.categories = categories
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
        for category: CategoryModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
        destination: router.makeDetailView(for: category)) { content() }
    }
}
