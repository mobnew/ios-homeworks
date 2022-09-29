//
//  Checker.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 25.08.2022.
//

import UIKit

final class Checker {
    static var shared = Checker()
    
    private let loginPrivate: String = "rr"
    private let passPrivate: String = "qq"
    private let userHomer = User(login: "homer", fullName: "Homer Simpson", status: "Sleep", avatar: UIImage(named: "h2")!)
    
    func check(login: String,
               pass: String,
               completion: @escaping (Result<User, LoginErrors>) -> Void
    ) {
        if (login == loginPrivate) && (pass == passPrivate) {
            completion(.success(userHomer))
        } else {
            completion(.failure(LoginErrors.notAuthorized))
            return
        }
    }
}
