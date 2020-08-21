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
    func getCategories(result: @escaping (Result<Results<CategoryEntity>, DatabaseError>) -> Void)
    func addCategories(categories: [CategoryModel], result: @escaping (Result<Results<CategoryEntity>, DatabaseError>) -> Void)
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

    func getCategories(result: @escaping (Result<Results<CategoryEntity>, DatabaseError>) -> Void) {
        if let realm = realm {
            let categories: Results<CategoryEntity> = { realm.objects(CategoryEntity.self) }()
            result(.success(categories))
        } else {
            result(.failure(.invalidInstance))
        }
    }

    func addCategories(categories: [CategoryModel], result: @escaping (Result<Results<CategoryEntity>, DatabaseError>) -> Void) {
        if let realm = realm {
            do {
                try realm.write {
                    for category in categories {
                        let newCategory = CategoryEntity()
                        newCategory.id = category.id
                        newCategory.title = category.title
                        newCategory.image = category.image
                        newCategory.desc = category.description

                        realm.add(newCategory)
                    }
                    let categories: Results<CategoryEntity> = { realm.objects(CategoryEntity.self) }()
                    result(.success(categories))
                }
            } catch {
                result(.failure(.requestFailed))
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }
}
