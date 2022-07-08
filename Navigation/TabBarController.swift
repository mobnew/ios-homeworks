//
//  TabBarController.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 01.07.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let feedVC = UINavigationController(rootViewController: FeedViewController())
        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "square.grid.3x3.topright.fill")
        
        let profileVC = UINavigationController(rootViewController: LogInViewController())
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        
        viewControllers = [feedVC, profileVC]
    }
}
