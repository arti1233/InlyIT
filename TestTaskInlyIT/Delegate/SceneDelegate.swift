//
//  SceneDelegate.swift
//  TestTaskInlyIT
//
//  Created by Artsiom Korenko on 12.03.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navTabBarController = CustomTabBarController()
        let builder = ModuleBuilder()
        let router = Router(navigationTabBarController: navTabBarController, builder: builder)
        router.initialViewControllers()
        guard let window else { return }
        window.rootViewController = navTabBarController
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}


}

