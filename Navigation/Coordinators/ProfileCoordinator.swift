//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 13.09.2022.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    let screenAssembly = ScreenAssembly()
    
    func start() {
        let loginVC = screenAssembly.createLogin(coordinator: self)
        loginVC.tabBarItem.title = "Profile"
        loginVC.tabBarItem.image = UIImage(systemName: "person")
        navigationController.pushViewController(loginVC, animated: false)
    }
    
    func toProfileViewController(with user: User) {
        let profileVC = screenAssembly.createProfile(user: user, coordinator: self)
        navigationController.pushViewController(profileVC, animated: true)
    }
    
    func toPhotosViewController() {
        let photoVC = screenAssembly.createPhoto()
        navigationController.pushViewController(photoVC, animated: true)
    }
}
