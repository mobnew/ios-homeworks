//
//  LoginInspector.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 26.08.2022.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, pass: String, complition: ((_ user: User?, _ error: LoginError?) -> ())?) {
        
        var user: User?
        let checkerService = CheckerService()
        checkerService.checkCredentials(login: login, pass: pass) { result in
            
            switch result {
            case .success(let myUser):
                user = myUser
                complition?(user, nil)
            case .failure(let myError):
                complition?(nil, myError)
            }
        }
    }
    
    func createUser(login: String, pass: String, complition: ((_ user: User?, _ error: LoginError?) -> ())?) {
        var user: User?
        let checkerService = CheckerService()
        checkerService.createUser(login: login, pass: pass) { result in
            
            switch result {
            case .success(let myUser):
                user = myUser
                complition?(user, nil)
            case .failure(let myError):
                complition?(nil, myError)
            }
        }
    }
}
