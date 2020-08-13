//
//  RemoteRepository.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol RemoteDataSourceProtocol: class {
    func getMeals(result: @escaping (Result<[MealResponse], URLError>) -> Void)
}

class RemoteDataSource: RemoteDataSourceProtocol {

    func getMeals(result: @escaping (Result<[MealResponse], URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.categories.url) else { return }

        let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
            if maybeError != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(MealsResponse.self, from: data)
                    result(.success(response.meals))
                } catch {
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
}
