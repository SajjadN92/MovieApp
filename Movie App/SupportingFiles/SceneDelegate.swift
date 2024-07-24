//
//  SceneDelegate.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: MovieSearchModule.build(with: MovieSearchModule.Configuration(context: MainContext())))
        window?.makeKeyAndVisible()
    }

}

