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
  @EnvironmentObject var networkMonitor: NetworkMonitor

  var body: some View {
    VStack {
      SearchBar(
        text: $presenter.title,
        onSearchButtonClicked: presenter.searchMeal
      )

      ZStack {
        if presenter.isLoading {
          loadingIndicator
        } else if presenter.isError {
          errorIndicator
        } else if presenter.title.isEmpty {
          emptyTitle
        } else if presenter.meals.isEmpty {
          emptyMeals
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
      Spacer()
    }.navigationBarTitle(
      Text("Search Meals"),
      displayMode: .automatic
    )
  }
}

extension SearchView {

  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }

  var errorIndicator: some View {
    CustomEmptyView(
      image: "assetSearchNotFound",
      title: presenter.errorMessage
    ).offset(y: 80)
  }

  var emptyTitle: some View {
    CustomEmptyView(
      image: "assetSearchMeal",
      title: "Come on, find your favorite food!"
    )
  }
  var emptyMeals: some View {
    CustomEmptyView(
      image: "assetSearchNotFound",
      title: networkMonitor.isConnected
      ? "Data not found"
      : "The internet connection is offline, please try again later!"
    ).offset(y: 80)
  }

}
