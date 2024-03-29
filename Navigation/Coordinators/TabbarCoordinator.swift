//
//  TabbarCoordinator.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 13.09.2022.
//

import UIKit

class TabbarCoordinator: TabbarCoordinatorProtocol {
    
    var tabbarController: UITabBarController
    
    var coordinatorNavFeed: Coordinator?
    var coordinatorNavProfile: Coordinator?
    
    init(tabbarController: UITabBarController) {
        self.tabbarController = tabbarController
    }
    
    func start() {
        let navFeedController = UINavigationController()
        coordinatorNavFeed = FeedCoordinator(navigationController: navFeedController)
        coordinatorNavFeed?.start()
        let feed = coordinatorNavFeed!
        
        let navProfileController = UINavigationController()
        coordinatorNavProfile = ProfileCoordinator(navigationController: navProfileController)
        coordinatorNavProfile?.start()
        let profile = coordinatorNavProfile!
        
        tabbarController.viewControllers = [feed.navigationController, profile.navigationController]
    }
}
