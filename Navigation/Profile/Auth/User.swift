//
//  User.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 24.08.2022.
//

import Foundation
import UIKit

protocol UserService {
    func checkPass(login: String, pass: String) -> User?
}

class User {
    let login: String
    let fullName: String
    let status: String
    let avatar: UIImage
    
    init(login: String, fullName: String, status: String, avatar: UIImage) {
        self.login = login
        self.fullName = fullName
        self.status = status
        self.avatar = avatar
    }
}

class CurrentUserService: UserService {
    private let user = User(login: "homer", fullName: "Homer Simpson", status: "Sleep", avatar: UIImage(named: "h2")!)
    private let userPass = "zzz"
    
    func checkPass(login: String, pass: String) -> User? {
        if (login == user.login) && (pass == userPass) {
            return user
        } else {
            return nil
        }
    }
}

class TestUserService: UserService {
    private let testUser = User(login: "t", fullName: "Test User", status: "Test", avatar: UIImage(named: "no")!)
    private let testUserPass = "q"
    
    func checkPass(login: String, pass: String) -> User? {
        if (login == testUser.login) && (pass == testUserPass) {
            return testUser
        } else {
            return nil
        }
    }
}
