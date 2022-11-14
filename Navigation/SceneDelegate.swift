//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 01.07.2022.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: TabbarCoordinatorProtocol?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                print("Not autorized")
            } else {
                print("auth ok")
                //запилить, что если авторизован, то сразу на экран пользака
            }
        }
        
        appConfiguration = AppConfiguration.allCases.randomElement()
        
        
        let tabController = UITabBarController()
        coordinator = TabbarCoordinator(tabbarController: tabController)
        coordinator?.start()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

