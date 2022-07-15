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
  func addCategories(
    from categories: [CategoryEntity],
    result: @escaping (Result<[CategoryEntity], DatabaseError>) -> Void
  )

}

final class LocaleDataSource: NSObject {

  private let realm: Realm?
  
  private init(realm: Realm?) {
    self.realm = realm
  }
  
  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }

}

extension LocaleDataSource: LocaleDataSourceProtocol {

  func getCategories(
    result: @escaping (Result<[CategoryEntity], DatabaseError>) -> Void
  ) {
    if let realm = realm {
      let categories: Results<CategoryEntity> = {
        realm.objects(CategoryEntity.self)
          .sorted(byKeyPath: "title", ascending: true)
      }()
      result(.success(categories.toArray(ofType: CategoryEntity.self)))
    } else {
      result(.failure(.invalidInstance))
    }
  }

  func addCategories(
    from categories: [CategoryEntity],
    result: @escaping (Result<[CategoryEntity], DatabaseError>) -> Void
  ) {
    if let realm = realm {
      do {
        try realm.write {
          for category in categories {
            realm.add(category, update: .all)
          }
          getCategories { response in
            result(response)
          }
        }
      } catch {
        result(.failure(.requestFailed))
      }
    } else {
      result(.failure(.invalidInstance))
    }
  }

  func addMeals(
    by category: String,
    from meals: [MealEntity],
    result: @escaping (Result<[MealEntity], DatabaseError>) -> Void
  ) {
    if let realm = realm {
      do {
        try realm.write {
          for meal in meals {
            realm.add(meal, update: .all)
          }
        }
        getMeals(by: category) { response in
          result(response)
        }
      } catch {
        result(.failure(.requestFailed))
      }
    } else {
      result(.failure(.invalidInstance))
    }
  }

  func addMealsBy(
    _ title: String,
    from meals: [MealEntity],
    result: @escaping (Result<[MealEntity], DatabaseError>) -> Void
  ) {
    if let realm = realm {
      do {
        try realm.write {
          for meal in meals {
            if let mealEntity = realm.object(ofType: MealEntity.self, forPrimaryKey: meal.id) {
              if mealEntity.title == meal.title {
                meal.favorite = mealEntity.favorite
                realm.add(meal, update: .all)
              } else {
                realm.add(meal)
              }
            } else {
              realm.add(meal)
            }
          }
        }
        getMealsBy(title) { response in
          result(response)
        }

      } catch {
        result(.failure(.requestFailed))
      }
    } else {
      result(.failure(.invalidInstance))
    }
  }

  func getMealsBy(
    _ title: String,
    result: @escaping (Result<[MealEntity], DatabaseError>) -> Void
  ) {
    if let realm = realm {
      let meals: Results<MealEntity> = {
        realm.objects(MealEntity.self)
          .filter("title = '\(title)'")
          .sorted(byKeyPath: "title", ascending: true)
      }()
      result(.success(meals.toArray(ofType: MealEntity.self)))
    } else {
      result(.failure(.invalidInstance))
    }
  }

  func getMeal(
    by idMeal: String,
    result: @escaping (Result<MealEntity, DatabaseError>) -> Void
  ) {
    if let realm = realm {
      let meals: Results<MealEntity> = {
        realm.objects(MealEntity.self)
          .filter("id = '\(idMeal)'")
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

  func getMeals(
    by category: String,
    result: @escaping (Result<[MealEntity], DatabaseError>) -> Void
  ) {
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

  func addIngredients(
    from ingredients: [IngredientEntity],
    result: @escaping (Result<[IngredientEntity], DatabaseError>) -> Void
  ) {
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

  func updateMeals(
    by idMeal: String, meal: MealEntity,
    result: @escaping (Result<MealEntity, DatabaseError>) -> Void
  ) {
    if let realm = realm {
      let mealEntity = { realm.objects(MealEntity.self).filter("id = '\(idMeal)'") }().first
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

        getMeal(by: idMeal) { response in
          result(response)
        }
      } catch {
        result(.failure(.requestFailed))
      }

    } else {
      result(.failure(.invalidInstance))
    }
  }

  func updateFavoriteMeal(
    by idMeal: String,
    result: @escaping (Result<MealEntity, DatabaseError>) -> Void
  ) {
    if let realm = realm, let mealEntity = { realm.objects(MealEntity.self).filter("id = '\(idMeal)'") }().first {
      do {
        try realm.write {
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

  func getFavoriteMeals(
    result: @escaping (Result<[MealEntity], DatabaseError>) -> Void
  ) {
    if let realm = realm {
      let mealEntities = {
        realm.objects(MealEntity.self)
          .filter("favorite = \(true)")
          .sorted(byKeyPath: "title", ascending: true)
      }()
      result(.success(mealEntities.toArray(ofType: MealEntity.self)))
    } else {
      result(.failure(.invalidInstance))
    }
  }

}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
