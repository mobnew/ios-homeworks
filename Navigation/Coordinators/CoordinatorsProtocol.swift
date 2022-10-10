//
//  CoordinatorProtocol.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 13.09.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
}

protocol TabbarCoordinatorProtocol: AnyObject {
    var tabbarController: UITabBarController { get set }
    
    func start()
}
