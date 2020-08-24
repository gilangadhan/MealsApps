//
//  LocaleDataSource.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 12/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation
import RealmSwift

protocol LocaleDataSourceProtocol: class {
    func getCategories(result: @escaping (Result<[CategoryEntity], DatabaseError>) -> Void)
    func addCategories(categories: [CategoryEntity], result: @escaping (Result<[CategoryEntity], DatabaseError>) -> Void)
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    private override init() {
        self.realm = try? Realm()
    }

    static func shared() -> LocaleDataSource {
        return LocaleDataSource()
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {

    func getCategories(result: @escaping (Result<[CategoryEntity], DatabaseError>) -> Void) {
        if let realm = realm {
            let categories: Results<CategoryEntity> = { realm.objects(CategoryEntity.self) }()
            result(.success(categories.toArray(ofType: CategoryEntity.self)))
        } else {
            result(.failure(.invalidInstance))
        }
    }

    func addCategories(categories: [CategoryEntity], result: @escaping (Result<[CategoryEntity], DatabaseError>) -> Void) {
        if let realm = realm {
            do {
                try realm.write {
                    for category in categories {
                        realm.add(category)
                    }
                    let categories: Results<CategoryEntity> = { realm.objects(CategoryEntity.self) }()
                    result(.success(categories.toArray(ofType: CategoryEntity.self)))
                }
            } catch {
                result(.failure(.requestFailed))
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }

    func getMealsByCategory(category: String, result: @escaping (Result<[MealEntity], DatabaseError>) -> Void) {
        if let realm = realm {
            let meals: Results<MealEntity> = {
                realm.objects(MealEntity.self)
                    .filter("category = '\(category)'")
                    .sorted(byKeyPath: "title", ascending: true)
            }()
            result(.success(meals.toArray(ofType: MealEntity.self)))
        } else {
            result(.failure(.invalidInstance))
        }
    }

    func addMealsByCategory(category: String, meals: [MealEntity], result: @escaping (Result<[MealEntity], DatabaseError>) -> Void) {
        if let realm = realm {
            do {
                try realm.write {
                    for meal in meals {
                        realm.add(meal)
                    }
                }

                let meals: Results<MealEntity> = {
                    realm.objects(MealEntity.self)
                        .filter("category = '\(category)'")
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                result(.success(meals.toArray(ofType: MealEntity.self)))
            } catch {
                result(.failure(.requestFailed))
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }

    func getMealsById(id: String, result: @escaping (Result<MealEntity, DatabaseError>) -> Void) {
        if let realm = realm {
            let meals: Results<MealEntity> = {
                realm.objects(MealEntity.self)
                    .filter("id = '\(id)'")
            }()

            guard let meal = meals.first else {
                result(.failure(.requestFailed))
                return
            }

            result(.success(meal))
        } else {
            result(.failure(.invalidInstance))
        }
    }

    func addIngredient(ingredients: [IngredientEntity], result: @escaping (Result<[IngredientEntity], DatabaseError>) -> Void) {
        if let realm = realm {
            do {
                try realm.write {
                    for ingredient in ingredients {
                        realm.add(ingredient)
                    }
                    let ingredients: Results<IngredientEntity> = { realm.objects(IngredientEntity.self) }()
                    result(.success(ingredients.toArray(ofType: IngredientEntity.self)))
                }
            } catch {
                result(.failure(.requestFailed))
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }

    func updateMealsById(id: String, meal: MealEntity, result: @escaping (Result<MealEntity, DatabaseError>) -> Void) {
        if let realm = realm {
            let mealEntity = { realm.objects(MealEntity.self).filter("id = '\(id)'") }().first
            do {
                try realm.write {
                    mealEntity?.setValue(meal.area, forKey: "area")
                    mealEntity?.setValue(meal.instructions, forKey: "instructions")
                    mealEntity?.setValue(meal.tag, forKey: "tag")
                    mealEntity?.setValue(meal.youtube, forKey: "youtube")
                    mealEntity?.setValue(meal.source, forKey: "source")
                    mealEntity?.setValue(meal.favorite, forKey: "favorite")
                    mealEntity?.setValue(meal.ingredients, forKey: "ingredients")
                }

                getMealsById(id: id) { localeEntity in
                    switch localeEntity {
                    case .success(let localeMeal):
                        result(.success(localeMeal))
                    case .failure(let error):
                        result(.failure(error))
                    }
                }
            } catch {
                result(.failure(.requestFailed))
            }

        } else {
            result(.failure(.invalidInstance))
        }
    }

    func updateFavoriteMeal(idMeal: String, result: @escaping (Result<MealEntity, DatabaseError>) -> Void) {
        if let realm = realm, let mealEntity = { realm.objects(MealEntity.self).filter("id = '\(idMeal)'") }().first {
            do {
                try realm.write {
                    print(mealEntity)
                    mealEntity.setValue(!mealEntity.favorite, forKey: "favorite")
                    result(.success(mealEntity))
                }
            } catch {
                result(.failure(.requestFailed))
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }

    func getFavoriteMeals(result: @escaping (Result<[MealEntity], DatabaseError>) -> Void) {
        if let realm = realm {
            let mealEntities = { realm.objects(MealEntity.self).filter("favorite = \(true)") }()
            result(.success(mealEntities.toArray(ofType: MealEntity.self)))
        } else {
            result(.failure(.invalidInstance))
        }
    }

}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
