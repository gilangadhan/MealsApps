//
//  RemoteRepository.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol RemoteDataSourceProtocol: class {
    func getMeals(completion: @escaping ([MealResponse]) -> Void)
}

class RemoteDataSource: RemoteDataSourceProtocol {

    func getMeals(completion: @escaping ([MealResponse]) -> Void) {
        guard let url = URL(string: Endpoints.Gets.categories.url) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, _ in
            guard let response = response as? HTTPURLResponse, let data = data else { return }

            if response.statusCode == 200 {
                let decoder = JSONDecoder()
                guard let response = try? decoder.decode(MealsResponse.self, from: data) else { return }

                completion(response.meals)
            }
        }

        task.resume()
    }
}
