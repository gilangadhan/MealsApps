//
//  HomeView.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    var meals: [Meal]?
    var interactor: HomeInteractorProtocol?
    var wireframe: HomeRouterProtocol?

    var body: some View {
        List {
            ForEach(presenter.meals, id: \.id) { meal in
                ZStack {
                    MovieRow(meal: meal)
                }
            }
        }
        .onAppear(perform: { self.presenter.getMeals() })
        .navigationBarTitle(Text("Movie Catalogue"), displayMode: .inline)
    }
}
