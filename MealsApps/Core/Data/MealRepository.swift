//
//  MealsRepository.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol MealRepositoryProtocol {
    func getCategories(result: @escaping (Result<[CategoryModel], Error>) -> Void)
    func getMealsByCategory(category: String, result: @escaping (Result<[MealModel], Error>) -> Void)
    func getMealById(id: String, result: @escaping (Result<MealModel, Error>) -> Void)
}

final class MealRepository: NSObject {
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource

    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }

    static func shared(locale: LocaleDataSource, remote: RemoteDataSource) -> MealRepository {
        return MealRepository(locale: locale, remote: remote)
    }
}

extension MealRepository: MealRepositoryProtocol {
    
    func getCategories(result: @escaping (Result<[CategoryModel], Error>) -> Void) {
        locale.getCategories { localeEntities in
            switch localeEntities {
            case .success(let categoryEntity):
                let categoryList = DataMapper.mapCategoryEntitiesToDomain(input: categoryEntity)
                if categoryList.isEmpty {
                    self.remote.getCategories { remoteResponses in
                        switch remoteResponses {
                        case .success(let categoryResponses):
                            let categoryEntities = DataMapper.mapCategoryResponsesToEntities(input: categoryResponses)
                            self.locale.addCategories(categories: categoryEntities) { addState in
                                switch addState {
                                case .success(let resultFromAdd):
                                    let resultList = DataMapper.mapCategoryEntitiesToDomain(input: resultFromAdd)
                                    result(.success(resultList))
                                    print(categoryList)
                                case .failure(let error):
                                    result(.failure(error))
                                }
                            }
                        case .failure(let error):
                            result(.failure(error))
                        }
                    }
                } else {
                    result(.success(categoryList))

                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func getMealsByCategory(category: String, result: @escaping (Result<[MealModel], Error>) -> Void) {
        locale.getMealsByCategory(category: category) { localeEntities in
            switch localeEntities {
            case .success(let mealsEntity):
                let mealList = DataMapper.mapMealsEntitiesToDomain(input: mealsEntity)
                if mealList.isEmpty {
                    self.remote.getMealsByCategory(category: category) { remoteResponses in
                        switch remoteResponses {
                        case .success(let mealResponses):
                            let mealEnitites = DataMapper.mapMealsResponsesToEntitiesByCategory(category: category, input: mealResponses)
                            self.locale.addMealsByCategory(category: category, meals: mealEnitites) { addState in
                                switch addState {
                                case .success(let resultFromAdd):
                                    let resultList = DataMapper.mapMealsEntitiesToDomain(input: resultFromAdd)
                                    result(.success(resultList))
                                case .failure(let error):
                                    result(.failure(error))
                                }
                            }
                        case .failure(let error):
                            result(.failure(error))
                        }
                    }
                } else {
                    result(.success(mealList))
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func getMealById(id: String, result: @escaping (Result<MealModel, Error>) -> Void) {
        locale.getMealsById(id: id) { localeEntity in
            switch localeEntity {
            case .success(let mealEntity):
                let mealModel = DataMapper.mapDetailMealEntityToDomain(input: mealEntity)
                if mealModel.ingredients.isEmpty {
                    self.remote.getMealById(id: id) { remoteResponse in
                        switch remoteResponse {
                        case .success(let mealResponse):
                            let mealEntity = DataMapper.mapDetailMealResponseToEntity(mealId: id, input: mealResponse)
                            self.locale.updateMealsById(id: id, meal: mealEntity) { updateState in
                                switch updateState {
                                case .success(let resultFromUpdate):
                                    let resultMeal = DataMapper.mapDetailMealEntityToDomain(input: resultFromUpdate)
                                    result(.success(resultMeal))
                                case .failure(let error):
                                    result(.failure(error))
                                }
                            }
                        case .failure(let error):
                            result(.failure(error))
                        }
                    }
                } else {
                    result(.success(mealModel))
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
