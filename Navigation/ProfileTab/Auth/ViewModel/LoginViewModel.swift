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
    
    func startChecker(login: String, pass: String) throws {
        if login.isEmpty {
            throw LoginErrors.emptyLogin
        }
        
        if pass.isEmpty {
            throw LoginErrors.emptyPassword
        }
        
        guard let lUser = loginFactory.makeLoginInspector().check(login: login, pass: pass) else {
            throw LoginErrors.notAuthorized}
        loginedUser = lUser
    }
}
