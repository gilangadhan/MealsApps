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
    @State var category: CategoryModel

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
                        WebImage(url: URL(string: self.category.image))
                            .resizable()
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .scaledToFit()
                            .frame(width: 250.0, height: 250.0, alignment: .center)
                        Spacer()

                        VStack(alignment: .leading, spacing: 0) {
                            Text("Meals from \(self.category.title)")
                                .font(.system(size: 20))
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(self.presenter.meals, id: \.id) { meal in
                                        ZStack {
                                            MealRow(meal: meal)
                                                .frame(width: 100, height: 100)
                                        }
                                    }
                                }
                            }
                            Spacer()
                            Text("Description")
                                .font(.system(size: 20))
                            Text(self.category.description)
                            .font(.system(size: 15))
                        }
                        Spacer()
                    }.padding()
                }
            }
        }.onAppear {
            self.presenter.getMealsByTitle(title: self.category.title)
        }.navigationBarTitle(Text(self.category.title), displayMode: .large)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let category: CategoryModel = CategoryModel(id: "1", title: "Beef", image: "https://www.themealdb.com/images/category/beef.png", description: "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2] Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2] Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2] Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2] Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2] Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]")
        let presenter = DetailPresenter(interactor:
            DetailInteractor(repository: MealRepository(locale: LocaleDataSource(), remote: RemoteDataSource())))
        return NavigationView {
            DetailView(presenter: presenter, category: category)
        }
    }
}
