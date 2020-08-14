//
//  HomePresenter.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

protocol HomePresenterProtocol: class {
    func interactor(_ interactor: HomeInteractorProtocol, didFetch object: Result<[CategoryModel], Error>)
}

class HomePresenter: ObservableObject {
    @Published var categories: [CategoryModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false

    private let router = HomeRouter()

    let interactor: HomeInteractorProtocol

    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
    }

    func getCategories() {
        loadingState = true
        interactor.getCategories()
    }

    func linkBuilder<Content: View>(
        for category: CategoryModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: category)) { content() }
    }
}

extension HomePresenter: HomePresenterProtocol {
    func interactor(_ interactor: HomeInteractorProtocol, didFetch result: Result<[CategoryModel], Error>) {
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
