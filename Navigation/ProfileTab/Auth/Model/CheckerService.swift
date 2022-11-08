//
//  CheckerService.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 25.10.2022.
//

import Foundation
import Firebase
import UIKit


protocol CheckerServiceProtocol {
    func checkCredentials(login: String, pass: String,
                          completion: @escaping (Result<User, LoginError>) -> Void)
    func createUser(login: String, pass: String, completion: @escaping (Result<User, LoginError>) -> ()?)
}


class CheckerService: CheckerServiceProtocol {
    private let userHomer = User(login: "homer", fullName: "Homer Simpson", status: "Sleep", avatar: UIImage(named: "h2")!)
    private let notHomer = User(login: "No", fullName: "No", status: "no Status", avatar: UIImage(named: "no")!)
    
    func checkCredentials(login: String, pass: String,
                          completion: @escaping (Result<User, LoginError>) -> Void) {
        Auth.auth().signIn(withEmail: login, password: pass) { result, error in
            if let error {
                let errString = "\(error)"
                if errString.contains("17011") {
                    completion(.failure(LoginError.notAuthorized))
                }
                
                if errString.contains("17009") {
                    completion(.failure(LoginError.wrongPass))
                }
                return
            }
            
            if let result {
                if result.user.uid == "FQCjEXcpVvW0AbbrHA8kSBggzD92" {
                    completion(.success(self.userHomer))
                } else {
                    completion(.success(self.notHomer))
                }
            }
        }
    }
    
    
    
     func createUser(login: String, pass: String, completion: @escaping (Result<User, LoginError>) -> ()?) {
        Auth.auth().createUser(withEmail: login, password: pass) { result, error in
            if let error {
                completion(.failure(LoginError.errorCreateUser))
                return
            }
            
            if let result {
                completion(.success(self.notHomer))
            }
        }
    }
}
