//
//  ScreenAssembly.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 16.09.2022.
//

import UIKit
import StorageService

protocol Assembly: AnyObject {
    func createPhoto() -> UIViewController
    func createLogin(coordinator: ProfileCoordinator) -> UIViewController
}

final class ScreenAssembly: Assembly {
    func createPhoto() -> UIViewController {
        let model = PhotoStorage.data
        let viewModel = PhotoViewModel(model: model)
        let view = PhotosViewController()
        
        view.viewModel = viewModel
        return view
    }
    
    func createLogin(coordinator: ProfileCoordinator) -> UIViewController {
        let model = MyLoginFactory()
        let viewModel = LoginViewModel(model: model)
        
        let passGenerator = PasswordGenerator()
        let bruteModel = passGenerator.getRandomPass(characterSet: passGenerator.letters, passLength: 4)
        let bruteViewModel = BruteforceViewModel(model: bruteModel)
        
        let view = LogInViewController()
        view.coordinator = coordinator
        
        view.viewModel = viewModel
        view.bruteViewModel = bruteViewModel
        
        return view
    }
    
    func createProfile(user: User, coordinator: ProfileCoordinator) -> UIViewController {
        let cartoons = Storage.data
        let viewModel = ProfileViewModel(userfromLogin: user,
                                         cartoons: cartoons)
        let view = ProfileViewController()
        view.coordinator = coordinator
        
        view.viewModel = viewModel
        return view
    }
}
