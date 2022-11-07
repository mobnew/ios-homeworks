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
    
    var loginError: LoginError? {
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
            throw LoginError.emptyLogin
        }
        
        if pass.isEmpty {
            throw LoginError.emptyPassword
        }

        loginFactory.makeLoginInspector().check(login: login, pass: pass) { user, error in
            if error != nil {
                self.loginError = error
                return
            }
            
            guard let user else {
                return
            }
            
            self.loginedUser = user
        }
    }
    
    func createUser(login: String, pass: String) throws {
        if login.isEmpty { throw LoginError.emptyLogin }
        if pass.isEmpty { throw LoginError.emptyPassword }
        if pass.count < 6 {throw LoginError.passLess6 }
        if !isValidEmail(testStr: login) { throw LoginError.wrongLoginFormat}
        
        loginFactory.makeLoginInspector().createUser(login: login, pass: pass) { user, error in
            if error != nil {
                self.loginError = error
                return
            }
            
            guard let user else {
                return
            }
            
            self.loginedUser = user
        }
    }
    
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
