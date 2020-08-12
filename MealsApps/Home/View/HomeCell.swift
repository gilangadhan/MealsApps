//
//  HomeRow.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct MovieRow: View {
    var meal: Meal

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(meal.title)
                    .font(.system(size: 20))
                Text(meal.description)
                    .font(.system(size: 14))
                    .lineLimit(3)
            } .padding(.leading, 8)

        }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
}
