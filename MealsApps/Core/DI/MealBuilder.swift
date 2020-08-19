//
//  MealBuilder.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 12/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

enum MealsView {
    case home, detail
}

class MealBuilder {
    
    class func buildModule(view: MealsView) -> Any {
        
        let locale = LocaleDataSource()
        let remote = RemoteDataSource()
        let repository = MealRepository(locale: locale, remote: remote)
        
        switch view {
        case .home:
            let interactor = HomeInteractor(repository: repository)
            let presenter = HomePresenter(interactor: interactor)
            interactor.presenter = presenter
            return presenter
        case .detail:
            let interactor = DetailInteractor(repository: repository)
            let presenter = DetailPresenter(interactor: interactor)
            interactor.presenter = presenter
            return presenter
        }
    }
}
