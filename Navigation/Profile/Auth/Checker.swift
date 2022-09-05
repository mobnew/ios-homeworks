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
    var user: User?
    
    func check(login: String, pass: String) -> Bool {
        if (login == loginPrivate) && (pass == passPrivate) {
             user = userHomer
            return true
        } else {
            return false
        }
    }
}
