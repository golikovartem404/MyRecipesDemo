//
//  SceneDelegate.swift
//  MyRecipes
//
//  Created by User on 05.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationVC = UINavigationController()
        let builder = ModuleBuilder()
        let router = Router(navigationController: navigationVC, assemblyBuilder: builder)
        router.initialViewController()
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
}

