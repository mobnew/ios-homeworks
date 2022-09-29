//
//  LoginErrors.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 27.09.2022.
//

import Foundation


enum LoginErrors: Error {
    case emptyLogin
    case emptyPassword
    case notAuthorized
}

extension LoginErrors: CustomStringConvertible {
    var description: String {
        switch self {
        case .emptyLogin: return "Пустой логин"
        case .emptyPassword: return "Пустой пароль"
        case .notAuthorized: return "Не верная пара логин/пароль"
        }
    }
}
