//
//  DetailView.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 13/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
  @ObservedObject var presenter: DetailPresenter
  @Binding var isPresentModal: Bool
  private let router = DetailRouter()
  
  var body: some View {
    NavigationView {
      ZStack {
        if presenter.loadingState {
          loadingIndicator
        } else {
          ScrollView(.vertical) {
            ZStack(alignment: .topTrailing) {
              CloseButton()
                .padding(16)
                .onTapGesture {
                    self.isPresentModal.toggle()
                }
              
              VStack {
                imageCategory
                  .animation(Animation.spring())
                spacer
                content
                spacer
              }.padding()
            }
          }
        }
      }.onAppear {
        if self.presenter.meals.count == 0 {
          self.presenter.getMeals()
        }
      }
      .navigationBarTitle("Detail")
      .navigationBarHidden(true)
    }
  }
}

extension DetailView {
  var spacer: some View {
    Spacer()
  }
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }
  
  var imageCategory: some View {
    WebImage(url: URL(string: self.presenter.category.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .frame(width: 250.0, height: 250.0, alignment: .center)
  }
  
  var mealsHorizontal: some View {
    ScrollView(.horizontal) {
      HStack {
        ForEach(self.presenter.meals, id: \.id) { meal in
          self.presenter.linkBuilder(for: meal) {
            MealRow(meal: meal)
              .frame(width: 150, height: 150)
          }.buttonStyle(PlainButtonStyle())
        }
      }
    }
  }
  
  var description: some View {
    Text(self.presenter.category.description)
      .font(.system(size: 15))
  }
  
  func headerTitle(_ title: String) -> some View {
    return Text(title)
      .font(.headline)
  }
  
  var content: some View {
    VStack(alignment: .leading, spacing: 0) {
      headerTitle("Meals from \(self.presenter.category.title)")
        .padding(.bottom)
      mealsHorizontal
        .animation(Animation.spring().delay(0.7))
      spacer
      headerTitle("Description")
        .padding([.top, .bottom])
      description
        .animation(Animation.easeIn(duration: 1.8))
    }
  }
}
