//
//  MealRow.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 14/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MealRow: View {
    var meal: MealModel

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                WebImage(url: URL(string: self.meal.image))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                BlurView()
                    .frame(width: geometry.size.width, height: 24)
                Text(self.meal.title)
                    .font(.system(size: 12))
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 4, trailing: 8))
            }
        }.cornerRadius(12)
    }
}
