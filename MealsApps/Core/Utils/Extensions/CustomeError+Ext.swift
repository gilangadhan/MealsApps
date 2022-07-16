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
  case offlineMode

  var errorDescription: String? {
    switch self {
    case .invalidResponse: return "The server responded with garbage."
    case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
    case .offlineMode: return "Data is empty because the internet connection is offline. Please try again later!"

    }
  }

}

enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed
  case emptyFavorite
  case emptyData

  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    case .emptyFavorite: return "Favorite item is empty. Please select your favorite meals!"
    case .emptyData: return "Data is empty. Please try again later!"

    }
  }

}
