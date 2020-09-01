//
//  SearchPresenter.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 31/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

class SearchPresenter: ObservableObject {

  private let router = SearchRouter()
  private let searchUseCase: SearchUseCase

  @Published var meals: [MealModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  var title = ""

  init(searchUseCase: SearchUseCase) {
    self.searchUseCase = searchUseCase
  }

  func searchMeal() {
    loadingState = true
    searchUseCase.searchMeal(by: title) { result in
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
