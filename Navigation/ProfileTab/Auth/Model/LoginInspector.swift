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
       // Checker.shared.check(login: login, pass: pass) { result in
//            print("Login inspector \(result)")
            switch result {
            case .success(let myUser):
                user = myUser
//                print("\(user?.login) -- \(myUser.login)")
                complition?(user, nil)
            case .failure(let myError):
                //тут обработать ошибки
                
//                print("======\(myError.description)")
                complition?(nil, myError)
            }
        }
//        return user
       
    }
}
