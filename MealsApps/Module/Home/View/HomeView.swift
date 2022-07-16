//
//  HomeView.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var networkMonitor: NetworkMonitor
  @ObservedObject var presenter: HomePresenter

  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        errorIndicator
      } else if presenter.categories.isEmpty {
        emptyCategories
      } else {
        content
      }
    }.onAppear {
      if self.presenter.categories.count == 0 {
        self.presenter.getCategories()
      }
    }.navigationBarTitle(
      Text("Meals Apps"),
      displayMode: .automatic
    )
  }

}

extension HomeView {

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

  var emptyCategories: some View {
    CustomEmptyView(
      image: "assetNoFavorite",
      title: networkMonitor.isConnected
      ? "The meal category is empty"
      : "The internet connection is offline, please try again later!"
    ).offset(y: 80)
  }

  var content: some View {
    ScrollView(.vertical, showsIndicators: false) {
      ForEach(
        self.presenter.categories,
        id: \.id
      ) { category in
        ZStack {
          self.presenter.linkBuilder(for: category) {
            CategoryRow(category: category)
          }.buttonStyle(PlainButtonStyle())
        }.padding(8)
      }
    }
  }
}
