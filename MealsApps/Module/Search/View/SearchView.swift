//
//  ProfileView.swift
//  MealsApps
//
//  Created by Ari Supriatna on 25/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct SearchView: View {

  @ObservedObject var presenter: SearchPresenter
  
  var body: some View {
    VStack {
      SearchBar(
        text: $presenter.title,
        onSearchButtonClicked: presenter.searchMeal
      )

      ZStack {
        if presenter.loadingState {
          VStack {
            Text("Loading...")
            ActivityIndicator()
          }
        } else {
          if presenter.title.isEmpty {
            Text("Come on, find your favorite food!")
          } else if !(presenter.meals.count > 0) {
            Text("Keyword not found...")
          } else {
            ScrollView(.vertical, showsIndicators: false) {
              ForEach(
                self.presenter.meals,
                id: \.id
              ) { meal in
                ZStack {
                  self.presenter.linkBuilder(for: meal) {
                    SearchRow(meal: meal)
                  }.buttonStyle(PlainButtonStyle())
                }.padding(8)
              }
            }
          }
        }
      }

      Spacer()
    }.navigationBarTitle(
      Text("Search Meals"),
      displayMode: .automatic
    )
  }
}
