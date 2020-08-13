//
//  CustomeError.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 13/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

enum URLError: LocalizedError {
    case invalidResponse
    case addressUnreachable(URL)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server responded with garbage."
        case .addressUnreachable(let url):
            return "\(url.absoluteString) is unreachable."
        }
    }
}
