//
//  DataMapper.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 21/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import RealmSwift

final class DataMapper {
    static func mapCategoryResponsesToEntities(input: [CategoryResponse]) -> [CategoryEntity] {
        return input.map { result in
            let newCategory = CategoryEntity()
            newCategory.id = result.id ?? ""
            newCategory.title = result.title ?? "Unknow"
            newCategory.image = result.image ?? "Unknow"
            newCategory.desc = result.description ?? "Unknow"
            return newCategory
        }
    }

    static func mapCategoryEntitiesToDomain(input: Results<CategoryEntity>) -> [CategoryModel] {
        return input.map { result in
            return CategoryModel(id: result.id, title: result.title, image: result.image, description: result.desc)
        }
    }

    static func mapCategoryResponseToDomain(input: [CategoryResponse]) -> [CategoryModel] {
        var categories: [CategoryModel] = []

        for category in input {
            if let id = category.id, let title = category.title, let image = category.image, let description = category.description {
                categories.append(CategoryModel(id: id, title: title, image: image, description: description))
            }
        }

        return categories
    }
}
