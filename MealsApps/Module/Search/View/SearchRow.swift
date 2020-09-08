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
      HStack(alignment: .top) {
        imageCategory
        content
        Spacer()
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 8)

      Divider()
        .padding(.leading)
    }
  }

}

extension SearchRow {

  var imageCategory: some View {
    WebImage(url: URL(string: meal.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .frame(width: 120)
      .cornerRadius(20)
  }

  var content: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(meal.title)
        .font(.system(size: 20, weight: .semibold, design: .rounded))
        .lineLimit(3)

      Text(meal.category)
        .font(.system(size: 16))
        .lineLimit(2)

      Text("From \(meal.area)")
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

struct SearchRow_Previews: PreviewProvider {

  static var previews: some View {
    let meal = MealModel(
      id: "1",
      title: "Cheese Burger Beef",
      image: "https://hips.hearstapps.com/del.h-cdn.co/assets/16/14/1459797520-delish-skinny-orange-chicken-1.jpg",
      category: "Beef"
    )
    return FavoriteRow(meal: meal)
  }

}
