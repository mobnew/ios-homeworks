//
//  LoginInspector.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 26.08.2022.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, pass: String) -> User? {
        
        var user: User?
        Checker.shared.check(login: login, pass: pass) { result in
            switch result {
            case .success(let myUser):
                user = myUser
            case .failure( _):
                return
            }
        }
        return user
    }
}
