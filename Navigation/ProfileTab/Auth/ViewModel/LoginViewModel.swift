//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 16.09.2022.
//

import Foundation

class LoginViewModel {
    static var loginFactoryDelegate: LoginFactory?
    
    var loginFactory: LoginFactory
    var loginedUser: User? {
        didSet {
            self.checkerIsLaunched?(self)
        }
    }
    
    var checkerIsLaunched: ((LoginViewModel) -> ())?
    
    init(model: LoginFactory) {
        self.loginFactory = model
    }
    
    func startChecker(login: String, pass: String) {
        if loginFactory.makeLoginInspector().check(login: login, pass: pass) {
            loginedUser = Checker.shared.user
        } else {
            loginedUser = nil
        }
    }
}