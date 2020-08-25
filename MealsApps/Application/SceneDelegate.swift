//
//  SceneDelegate.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let homeUseCase = Injection.init().provideHome()
        let favoriteUseCase = Injection.init().provideFavorite()
      
        let homePresenter = HomePresenter(homeUseCase: homeUseCase)
        let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)

        let contentView = ContentView()
          .environmentObject(homePresenter)
          .environmentObject(favoritePresenter)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
}
