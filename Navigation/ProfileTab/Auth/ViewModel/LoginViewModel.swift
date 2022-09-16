//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 16.09.2022.
//

import Foundation

protocol LoginViewModelProtocol: AnyObject {
    
    var loginFactory: LoginFactory { get set }
    var loginedUser: User? { get }
    var checkerIsLaunched: ((LoginViewModel) ->())? { get set }
    
    func startChecker(login: String, pass: String)
}

class LoginViewModel: LoginViewModelProtocol {
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
