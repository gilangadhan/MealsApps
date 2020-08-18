//
//  MealView.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 14/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MealView: View {
    @ObservedObject var presenter: MealPresenter
    var interactor: MealInteractorProtocol?

    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading...")
                    ActivityIndicator()
                }
            } else {
                ScrollView(.vertical) {
                    VStack {
                        WebImage(url: URL(string: self.presenter.meal.image))
                            .resizable()
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .scaledToFit()
                            .frame(width: 250.0, height: 250.0, alignment: .center)
                        Spacer()

                        VStack(alignment: .leading, spacing: 0) {
                            Text("Instructions")
                                .font(.system(size: 20))
                            Text(self.presenter.meal.instructions ?? "Unknow")
                                .font(.system(size: 15))

                            Spacer()
                            Text("Ingredient")
                                .font(.system(size: 20))
                        }

                        List {
                            ForEach(Array(presenter.meal.ingredient.enumerated()), id: \.1.self) { (index, ingredient) in
                                Text("\(index+1). \(ingredient)")
                                    .font(.system(size: 14))
                            }
                        }

                        Spacer()
                    }.padding()
                }
            }
        }.onAppear {
            if !(self.presenter.meal.ingredient.count > 0) {
                self.presenter.getMealById(id: self.presenter.meal.id)
            }
        }.navigationBarTitle(Text(presenter.meal.title), displayMode: .automatic)
    }
}
