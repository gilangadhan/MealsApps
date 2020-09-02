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
  func getMeals(by category: String, result: @escaping (Result<[MealModel], Error>) -> Void)
  func getMeal(by idMeal: String, result: @escaping (Result<MealModel, Error>) -> Void)
  func getFavoriteMeals(result: @escaping (Result<[MealModel], Error>) -> Void)
  func updateFavoriteMeal(by idMeal: String, result: @escaping (Result<MealModel, Error>) -> Void)
  func searchMeal(by title: String, result: @escaping (Result<[MealModel], Error>) -> Void)

}

final class MealRepository: NSObject {

  typealias MealInstance = (LocaleDataSource, RemoteDataSource) -> MealRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource

  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }

  static let sharedInstance: MealInstance = { localeRepo, remoteRepo in
    return MealRepository(locale: localeRepo, remote: remoteRepo)
  }

}

extension MealRepository: MealRepositoryProtocol {

  func getCategories(
    result: @escaping (Result<[CategoryModel], Error>) -> Void
  ) {
    locale.getCategories { localeResponses in
      switch localeResponses {
      case .success(let categoryEntity):
        let categoryList = CategoryMapper.mapCategoryEntitiesToDomains(input: categoryEntity)
        if categoryList.isEmpty {
          self.remote.getCategories { remoteResponses in
            switch remoteResponses {
            case .success(let categoryResponses):
              let categoryEntities = CategoryMapper.mapCategoryResponsesToEntities(input: categoryResponses)
              self.locale.addCategories(from: categoryEntities) { addState in
                switch addState {
                case .success(let resultFromAdd):
                  let resultList = CategoryMapper.mapCategoryEntitiesToDomains(input: resultFromAdd)
                  result(.success(resultList))
                case .failure(let error): result(.failure(error))
                }
              }
            case .failure(let error): result(.failure(error))
            }
          }
        } else {
          result(.success(categoryList))
        }
      case .failure(let error): result(.failure(error))
      }
    }
  }

  func getMeals(
    by category: String,
    result: @escaping (Result<[MealModel], Error>) -> Void
  ) {
    locale.getMeals(by: category) { localeResponses in
      switch localeResponses {
      case .success(let mealsEntity):
        let mealList = MealMapper.mapMealEntitiesToDomains(input: mealsEntity)
        if mealList.isEmpty {
          self.remote.getMeals(by: category) { remoteResponses in
            switch remoteResponses {
            case .success(let mealResponses):
              let mealEnitites = MealMapper.mapMealResponsesToEntities(
                by: category,
                input: mealResponses
              )
              self.locale.addMeals(by: category, from: mealEnitites) { addState in
                switch addState {
                case .success(let resultFromAdd):
                  let resultList = MealMapper.mapMealEntitiesToDomains(input: resultFromAdd)
                  result(.success(resultList))
                case .failure(let error): result(.failure(error))
                }
              }
            case .failure(let error): result(.failure(error))
            }
          }
        } else {
          result(.success(mealList))
        }
      case .failure(let error): result(.failure(error))
      }
    }
  }

  func getMeal(
    by idMeal: String,
    result: @escaping (Result<MealModel, Error>) -> Void
  ) {
    locale.getMeal(by: idMeal) { localeResponse in
      switch localeResponse {
      case .success(let mealEntity):
        let mealModel = MealMapper.mapDetailMealEntityToDomain(input: mealEntity)
        if mealModel.ingredients.isEmpty {
          self.remote.getMeal(by: idMeal) { remoteResponse in
            switch remoteResponse {
            case .success(let mealResponse):
              let mealEntity = MealMapper.mapDetailMealResponseToEntity(by: idMeal, input: mealResponse)
              self.locale.updateMeals(by: idMeal, meal: mealEntity) { updateState in
                switch updateState {
                case .success(let resultFromUpdate):
                  let resultMeal = MealMapper.mapDetailMealEntityToDomain(input: resultFromUpdate)
                  result(.success(resultMeal))
                case .failure(let error): result(.failure(error))
                }
              }
            case .failure(let error): result(.failure(error))
            }
          }
        } else {
          result(.success(mealModel))
        }
      case .failure(let error): result(.failure(error))
      }
    }
  }

  func getFavoriteMeals(
    result: @escaping (Result<[MealModel], Error>) -> Void
  ) {
    locale.getFavoriteMeals { localeResponse in
      switch localeResponse {
      case .success(let localeEntities):
        let resultMeals = MealMapper.mapMealEntitiesToDomains(input: localeEntities)
        result(.success(resultMeals))
      case .failure(let error): result(.failure(error))
      }
    }
  }

  func updateFavoriteMeal(
    by idMeal: String,
    result: @escaping (Result<MealModel, Error>) -> Void
  ) {
    locale.updateFavoriteMeal(by: idMeal) { localeResponse in
      switch localeResponse {
      case .success(let localeEntity):
        let resultMeal = MealMapper.mapDetailMealEntityToDomain(input: localeEntity)
        result(.success(resultMeal))
      case .failure(let error): result(.failure(error))
      }
    }
  }

  func searchMeal(
    by title: String,
    result: @escaping (Result<[MealModel], Error>) -> Void
  ) {
    remote.searchMeal(by: title) { remoteResponse in
      switch remoteResponse {
      case .success(let mealResponses):
        let resultMeal = MealMapper.mapMealResponsesToDomains(input: mealResponses)
        self.locale.getMealsBy(title) { localeResponses in
          switch localeResponses {
          case .success(let mealEntities):
            if mealResponses.count > mealEntities.count {
              let meals = MealMapper.mapDetailMealResponseToEntity(input: mealResponses)
              self.locale.addMealsBy(title, from: meals) { addState in
                switch addState {
                case .success(let resultFromAdd):
                  let resultList = MealMapper.mapDetailMealEntityToDomains(input: resultFromAdd)
                  result(.success(resultList))
                case .failure(let error): result(.failure(error))
                }
              }
            } else {
              let resultList = MealMapper.mapDetailMealEntityToDomains(input: mealEntities)
              result(.success(resultList))
            }
          case .failure(let error): result(.failure(error))
          }
        }
        result(.success(resultMeal))
      case .failure(let error): result(.failure(error))
      }
    }
  }

}
