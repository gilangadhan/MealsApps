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

    static func mapCategoryEntitiesToDomain(input: [CategoryEntity]) -> [CategoryModel] {
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

    static func mapMealsResponsesToEntitiesByCategory(category: String, input: [MealResponse]) -> [MealEntity] {
        return input.map { result in
            let newMeal = MealEntity()
            newMeal.id = result.id ?? ""
            newMeal.title = result.title ?? "Unknow"
            newMeal.image = result.image ?? "Unknow"
            newMeal.category = category
            return newMeal
        }
    }

    static func mapIngredientEntitiesToDomain(input: [IngredientEntity]) -> [IngredientModel] {
        return input.map { result in
            return IngredientModel(id: result.id, title: result.title, mealId: result.mealId)
        }
    }

    static func mapMealsEntitiesToDomain(input: [MealEntity]) -> [MealModel] {
        return input.map { result in
            let newMeal = MealModel(id: result.id,
                                    title: result.title,
                                    image: result.image,
                                    category: result.category,
                                    area: result.area,
                                    instructions: result.instructions,
                                    tag: result.tag,
                                    youtube: result.youtube,
                                    source: result.source,
                                    ingredients: Array(_immutableCocoaArray: result.ingredients),
                                    favorite: result.favorite
            )
            return newMeal
        }
    }

    static func mapDetailMealEntityToDomain(input: MealEntity) -> MealModel {
        let mealEntity = input
        let ingredients = mapIngredientEntityToDomain(input: Array(mealEntity.ingredients))
        return MealModel(id: mealEntity.id ,
                         title: mealEntity.title,
                         image: mealEntity.image,
                         category: mealEntity.category,
                         area: mealEntity.area,
                         instructions: mealEntity.instructions,
                         tag: mealEntity.tag,
                         youtube: mealEntity.youtube,
                         source: mealEntity.source,
                         ingredients: ingredients,
                         favorite: mealEntity.favorite
        )
    }

    static func mapIngredientEntityToDomain(input: [IngredientEntity]) -> [IngredientModel] {
        return input.map { result in
            return IngredientModel(id: result.id, title: result.title, mealId: result.mealId)
        }
    }

    static func mapDetailMealResponseToEntity(mealId: String, input: MealResponse) -> MealEntity {
        let mealResponse = input
        let ingredients = mapIngredientResponseToEntity(mealId: mealId, meal: mealResponse)
        let mealEntity = MealEntity()
        mealEntity.id = mealResponse.id ?? ""
        mealEntity.title = mealResponse.title ?? "Unknow"
        mealEntity.image = mealResponse.image ?? "Unknow"
        mealEntity.category = mealResponse.category ?? "Unknow"
        mealEntity.area = mealResponse.area ?? "Unknow"
        mealEntity.instructions = mealResponse.instructions ?? "Unknow"
        mealEntity.tag = mealResponse.tag ?? "Unknow"
        mealEntity.youtube = mealResponse.youtube ?? "Unknow"
        mealEntity.source = mealResponse.source ?? "Unknow"
        mealEntity.ingredients = ingredients
        return mealEntity
    }

    static func mapIngredientResponseToEntity(mealId: String, meal: MealResponse) -> List<IngredientEntity> {
        let ingredientEntities = List<IngredientEntity>()
        var ingredients = [meal.ingredient1, meal.ingredient2, meal.ingredient3, meal.ingredient4,
                           meal.ingredient5, meal.ingredient6, meal.ingredient7, meal.ingredient8,
                           meal.ingredient9, meal.ingredient10, meal.ingredient11, meal.ingredient12,
                           meal.ingredient13, meal.ingredient14, meal.ingredient15, meal.ingredient16,
                           meal.ingredient17, meal.ingredient18, meal.ingredient19, meal.ingredient20]
            .compactMap { $0 }
        ingredients = ingredients.filter({ $0 != ""})
        var measures = [meal.measure1, meal.measure2, meal.measure3, meal.measure4,
                        meal.measure5, meal.measure6, meal.measure7, meal.measure8,
                        meal.measure9, meal.measure10, meal.measure11, meal.measure12,
                        meal.measure13, meal.measure14, meal.measure15, meal.measure16,
                        meal.measure17, meal.measure18, meal.measure19, meal.measure20]
            .compactMap { $0 }
        measures = measures.filter({ $0 != ""})
        let ingredientStrings = zip(ingredients, measures)
            .map { "\($0) \($1)" }
        for (index, ingredient) in ingredientStrings.enumerated() {
            let ingredientEntity = IngredientEntity()
            ingredientEntity.id = "\(index)"
            ingredientEntity.title = "\(index). \(ingredient)"
            ingredientEntity.mealId = mealId
            ingredientEntities.append(ingredientEntity)
        }

        return ingredientEntities
    }
}
