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
//                    print("User not found. Create new user.")
//                    completion(.failure(LoginError.notAuthorized))
                    self.createUser(login: login, pass: pass) { answer in
                        guard let answer else {
//                            print("Не пришел UID при создании")
                            completion(.failure(LoginError.errorCreateUser))
                            return
                        }
//                        print("создан пользователь \(login)")
                        completion(.success(self.notHomer))
                    }
                }
                
                if errString.contains("17009") {
//                    print("Wrong pass for user \(login)")
                    completion(.failure(LoginError.wrongPass))
                }
                return
            }
            
            if let result {
//                print("Result OK")
//                print(result.user.uid)
                if result.user.uid == "FQCjEXcpVvW0AbbrHA8kSBggzD92" {
                    completion(.success(self.userHomer))
                } else {
                    completion(.success(self.notHomer))
                }
            }
        }
    }
    
    
    
    private func createUser(login: String, pass: String, closure: ((_ answer: String?) -> ())?) {
        Auth.auth().createUser(withEmail: login, password: pass) { result, error in
            if let error {
//                print(error.localizedDescription)
                closure?(nil)
                return
            }
            
            if let result {
                closure?(result.user.uid)
            }
        }
    }
}
