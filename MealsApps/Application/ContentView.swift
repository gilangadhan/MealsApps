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

  var body: some View {
    HomeView(presenter: homePresenter)
  }

}
