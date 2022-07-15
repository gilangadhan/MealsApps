//
//  HomeView.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  
  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter
  @EnvironmentObject var searchPresenter: SearchPresenter
  @ObservedObject var presenter: HomePresenter
  @State var isPresentModal = false
  @State var selectedItem: CategoryModel?
  private let router = HomeRouter()
  
  var body: some View {
    ZStack {
      tabBar
      detailView
    }
  }
  
  var content: some View {
    ZStack {
      if presenter.loadingState {
        VStack {
          Text("Loading...")
          ActivityIndicator()
        }
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          ForEach(
            self.presenter.categories,
            id: \.id
          ) { category in
            ZStack {
              CategoryRow(category: category)
                .onTapGesture {
                  self.isPresentModal = true
                  self.selectedItem = category
                }.buttonStyle(PlainButtonStyle())
            }.padding(8)
          }
        }
      }
    }.onAppear {
      if self.presenter.categories.count == 0 {
        self.presenter.getCategories()
      }
    }
    .navigationBarTitle(
      Text("Meals Apps"),
      displayMode: .automatic
    )
  }
  
  var tabBar: some View {
    TabView {
      NavigationView {
        content
      }.tabItem {
        TabItem(imageName: "house", title: "Home")
      }

      NavigationView {
        SearchView(presenter: searchPresenter)
      }.tabItem {
        TabItem(imageName: "magnifyingglass", title: "Search")
      }

      NavigationView {
        FavoriteView(presenter: favoritePresenter)
      }.tabItem {
        TabItem(imageName: "heart", title: "Favorite")
      }
    }
  }
  
  @ViewBuilder
  var detailView: some View {
    if isPresentModal {
      self.router.makeDetailView(for: selectedItem!, isPresentModal: $isPresentModal)
    }
  }
  
}
