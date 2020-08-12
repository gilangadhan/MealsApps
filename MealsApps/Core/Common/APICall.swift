//
//  Endpoints.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

struct API {
    static let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {

    enum Gets: Endpoint {
        case categories

        public var url: String {
            switch self {
            case .categories: return "\(API.baseUrl)categories.php"
            }
        }
    }
}
