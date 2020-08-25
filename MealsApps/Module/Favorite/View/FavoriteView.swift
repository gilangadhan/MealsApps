//
//  FavoriteView.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 24/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter

    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading...")
                    ActivityIndicator()
                }
            } else {
                if presenter.meals.count == 0 {
                    Text("Empty...")
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(self.presenter.meals, id: \.id) { meal in
                            ZStack {
                                self.presenter.linkBuilder(for: meal) {
                                    FavoriteRow(meal: meal)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }
        }.onAppear {
            self.presenter.getFavoriteMeals()
        }.navigationBarTitle(Text("Favorite Meals"), displayMode: .automatic)
    }
}
