//
//  SceneDelegate.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit
import SwiftUI
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  internal var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    
    let homeUseCase = Injection.init().provideHome()
    let favoriteUseCase = Injection.init().provideFavorite()
    let searchUseCase = Injection.init().provideSearch()
    
    let homePresenter = HomePresenter(homeUseCase: homeUseCase)
    let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
    let searchPresenter = SearchPresenter(searchUseCase: searchUseCase)

    let contentView = ContentView()
      .environmentObject(homePresenter)
      .environmentObject(favoritePresenter)
      .environmentObject(searchPresenter)
      .environmentObject(NetworkMonitor())
    
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: contentView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
  
}

final class NetworkMonitor: ObservableObject {
  @Published var isConnected = true

  init() {
    if let network = NetworkReachabilityManager(), network.isReachable {
      isConnected = true
    } else {
      isConnected = false
    }
  }
}
