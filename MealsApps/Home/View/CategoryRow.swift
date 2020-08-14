//
//  HomeRow.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryRow: View {
    var category: CategoryModel

    var body: some View {
        HStack {
            WebImage(url: URL(string: category.image))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 100.0, height: 100.0, alignment: .center)

            VStack(alignment: .leading, spacing: 0) {
                Text(category.title)
                    .font(.system(size: 20))
                Text(category.description)
                    .font(.system(size: 14))
                    .lineLimit(3)
            }.padding(.leading, 8)

        }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
}
