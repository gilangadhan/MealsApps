//
//  RemoteRepository.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation
import Alamofire

protocol RemoteDataSourceProtocol: class {
    func getCategories(result: @escaping (Result<[CategoryResponse], URLError>) -> Void)
    func getMealsByTitle(title: String, result: @escaping (Result<[MealResponse], URLError>) -> Void)
    func getMealById(id: String, result: @escaping (Result<MealResponse, URLError>) -> Void)
}

final class RemoteDataSource: NSObject {
    private override init() { }

    static func shared() -> RemoteDataSource {
        return RemoteDataSource()
    }
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getCategories(result: @escaping (Result<[CategoryResponse], URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.categories.url) else { return }

        AF.request(url)
            .validate()
            .responseDecodable(of: CategoriesResponse.self) { response in
                switch response.result {
                case .success(let value):
                    result(.success(value.categories))
                case .failure:
                    result(.failure(.invalidResponse))
                }
        }
    }
    
    func getMealsByTitle(title: String, result: @escaping (Result<[MealResponse], URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.meals.url + title) else { return }

        AF.request(url)
            .validate()
            .responseDecodable(of: MealsResponse.self) { response in
                switch response.result {
                case .success(let value):
                    result(.success(value.meals))
                case .failure:
                    result(.failure(.invalidResponse))
                }
        }
    }
    
    func getMealById(id: String, result: @escaping (Result<MealResponse, URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.meal.url + id) else { return }

        AF.request(url)
            .validate()
            .responseDecodable(of: MealsResponse.self) { response in
                switch response.result {
                case .success(let value):
                    result(.success(value.meals[0]))
                case .failure:
                    result(.failure(.invalidResponse))
                }
        }
    }
}
