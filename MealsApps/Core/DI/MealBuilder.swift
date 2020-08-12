//
//  MealBuilder.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 12/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

class MealBuilder {

    class func buildModule() -> HomePresenter {

        let locale = LocaleDataSource()
        let remote = RemoteDataSource()
        let repository = MealRepository(locale: locale, remote: remote)
        let interactor = HomeInteractor(repository: repository)
        let presenter = HomePresenter(interactor: interactor)

        interactor.presenter = presenter
        return presenter
    }
}
