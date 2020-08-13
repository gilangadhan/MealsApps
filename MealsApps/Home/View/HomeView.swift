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

    var interactor: HomeInteractorProtocol?
    var wireframe: HomeRouterProtocol?
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading...")
                    ActivityIndicator()
                }
            } else {
                List {
                    ForEach(self.presenter.meals, id: \.id) { meal in
                        ZStack {
                            MovieRow(meal: meal)
                        }
                    }
                }
            }
        }
        .onAppear(perform: { self.presenter.getMeals() })
        .navigationBarTitle(Text("Movie Catalogue"), displayMode: .inline)
    }
}
