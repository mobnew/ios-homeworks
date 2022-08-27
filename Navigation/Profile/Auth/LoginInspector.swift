//
//  LoginInspector.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 26.08.2022.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate{
    func check(login: String, pass: String) -> Bool {
       return Checker.shared.check(login: login, pass: pass)
    }
}
