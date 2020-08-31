//
//  ContentView.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct ContentView: View {

  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter

  var body: some View {
    TabView {
      NavigationView {
        HomeView(presenter: homePresenter)
      }
      .tabItem {
        TabItem(imageName: "house", title: "Home")
      }

      NavigationView {
        FavoriteView(presenter: favoritePresenter)
      }
      .tabItem {
        TabItem(imageName: "heart", title: "Favorite")
      }

      NavigationView {
        ProfileView()
      }
      .tabItem {
        TabItem(imageName: "person.circle", title: "Profile")
      }
    }
  }
  
}
