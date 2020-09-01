//
//  SearchRow.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 31/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchRow: View {

  var meal: MealModel
  var body: some View {
    VStack {
      imageCategory
      content
      detailContent
    }
    .frame(width: UIScreen.main.bounds.width - 32, height: 250)
    .background(Color.random.opacity(0.3))
    .cornerRadius(30)
  }

}

extension SearchRow {

  var imageCategory: some View {
    WebImage(url: URL(string: meal.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .frame(width: 200)
      .cornerRadius(30)
      .padding(.top)
  }

  var content: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(meal.title)
        .font(.title)
        .bold()

    }
  }

  var detailContent: some View {
    HStack(alignment: .center) {
      Text("from \(meal.area)")
        .font(.system(size: 14))
        .lineLimit(2)
    }.padding(
      EdgeInsets(
        top: 0,
        leading: 16,
        bottom: 16,
        trailing: 16
      )
    )
  }

}
