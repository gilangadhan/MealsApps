//
//  LocaleDataSource.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 12/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol LocaleDataSourceProtocol: class {
    func getMeals()
}

class LocaleDataSource: LocaleDataSourceProtocol {
    func getMeals() {}
}
