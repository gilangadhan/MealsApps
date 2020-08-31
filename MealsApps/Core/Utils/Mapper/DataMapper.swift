//
//  DataMapper.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 21/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import RealmSwift

final class DataMapper {

  static func mapCategoryResponsesToEntities(
    input categoryResponses: [CategoryResponse]
  ) -> [CategoryEntity] {
    return categoryResponses.map { result in
      let newCategory = CategoryEntity()
      newCategory.id = result.id ?? ""
      newCategory.title = result.title ?? "Unknow"
      newCategory.image = result.image ?? "Unknow"
      newCategory.desc = result.description ?? "Unknow"
      return newCategory
    }
  }

  static func mapCategoryEntitiesToDomains(
    input categoryEntities: [CategoryEntity]
  ) -> [CategoryModel] {
    return categoryEntities.map { result in
      return CategoryModel(
        id: result.id,
        title: result.title,
        image: result.image,
        description: result.desc
      )
    }
  }

  static func mapCategoryResponsesToDomains(
    input categoryResponses: [CategoryResponse]
  ) -> [CategoryModel] {

    return categoryResponses.map { result in
      return CategoryModel(
        id: result.id ?? "",
        title: result.title ?? "Unknow",
        image: result.image ?? "Unknow",
        description: result.description ?? "Unknow"
      )
    }
  }

  static func mapMealsResponsesToEntities(
    by category: String,
    input mealResponses: [MealResponse]
  ) -> [MealEntity] {
    return mealResponses.map { result in
      let newMeal = MealEntity()
      newMeal.id = result.id ?? ""
      newMeal.title = result.title ?? "Unknow"
      newMeal.image = result.image ?? "Unknow"
      newMeal.category = category
      return newMeal
    }
  }

  static func mapMealResponsesToDomains(
    by category: String,
    input mealResponses: [MealResponse]
  ) -> [MealModel] {
    return mealResponses.map { result in
      var newMeal = MealModel(
        id: result.id ?? "",
        title: result.title ?? "Unknow",
        image: result.image ?? "Unknow"
      )
      newMeal.category = category
      return newMeal
    }
  }

  static func mapIngredientEntitiesToDomains(
    input ingredientEntities: [IngredientEntity]
  ) -> [IngredientModel] {
    return ingredientEntities.map { result in
      return IngredientModel(
        id: result.id,
        title: result.title,
        idMeal: result.idMeal
      )
    }
  }

  static func mapMealEntitiesToDomains(
    input mealEntities: [MealEntity]
  ) -> [MealModel] {
    return mealEntities.map { result in
      return MealModel(
        id: result.id,
        title: result.title,
        image: result.image,
        category: result.category
      )
    }
  }

  static func mapDetailMealEntityToDomain(
    input mealEntity: MealEntity
  ) -> MealModel {
    let ingredients = mapIngredientEntitiesToDomains(
      input: Array(mealEntity.ingredients)
    )
    return MealModel(
      id: mealEntity.id ,
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

  static func mapDetailMealResponseToEntity(
    by idMeal: String,
    input mealResponse: MealResponse
  ) -> MealEntity {
    let ingredients = mapIngredientResponseToEntity(
      by: idMeal,
      input: mealResponse
    )
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

  static func mapIngredientResponseToEntity(
    by idMeal: String,
    input mealResponse: MealResponse
  ) -> List<IngredientEntity> {
    let ingredientEntities = List<IngredientEntity>()
    var ingredients = [
      mealResponse.ingredient1, mealResponse.ingredient2,
      mealResponse.ingredient3, mealResponse.ingredient4,
      mealResponse.ingredient5, mealResponse.ingredient6,
      mealResponse.ingredient7, mealResponse.ingredient8,
      mealResponse.ingredient9, mealResponse.ingredient10,
      mealResponse.ingredient11, mealResponse.ingredient12,
      mealResponse.ingredient13, mealResponse.ingredient14,
      mealResponse.ingredient15, mealResponse.ingredient16,
      mealResponse.ingredient17, mealResponse.ingredient18,
      mealResponse.ingredient19, mealResponse.ingredient20
    ].compactMap { $0 }
    ingredients = ingredients.filter({ $0 != ""})

    var measures = [
      mealResponse.measure1, mealResponse.measure2,
      mealResponse.measure3, mealResponse.measure4,
      mealResponse.measure5, mealResponse.measure6,
      mealResponse.measure7, mealResponse.measure8,
      mealResponse.measure9, mealResponse.measure10,
      mealResponse.measure11, mealResponse.measure12,
      mealResponse.measure13, mealResponse.measure14,
      mealResponse.measure15, mealResponse.measure16,
      mealResponse.measure17, mealResponse.measure18,
      mealResponse.measure19, mealResponse.measure20
    ].compactMap { $0 }
    measures = measures.filter({ $0 != ""})

    let ingredientStrings = zip(ingredients, measures)
      .map { "\($0) \($1)" }

    for (index, ingredient) in ingredientStrings.enumerated() {
      let ingredientEntity = IngredientEntity()
      ingredientEntity.id = "\(index+1)"
      ingredientEntity.title = "\(index+1). \(ingredient)"
      ingredientEntity.idMeal = idMeal
      ingredientEntities.append(ingredientEntity)
    }

    return ingredientEntities
  }

}
