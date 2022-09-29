//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 26.08.2022.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(login: String, pass: String) -> User?
}
