//
//  CategoryInteractor.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol HomeInteractorProtocol: class {
    func getCategories()
}

class HomeInteractor: HomeInteractorProtocol {
    private let repository: MealRepositorProtocol
    
    var presenter: HomePresenterProtocol?
    
    required init(repository: MealRepositorProtocol) {
        self.repository = repository
    }
    
    func getCategories() {
        repository.getCategories { result in
            self.presenter?.interactor(self, didFetch: result)
        }
    }
}
