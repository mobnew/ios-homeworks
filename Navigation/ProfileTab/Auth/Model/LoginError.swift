//
//  LoginErrors.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 27.09.2022.
//

import Foundation


enum LoginError: Error {
    case emptyLogin
    case emptyPassword
    case notAuthorized
    case errorCreateUser
    case wrongPass
    case passLess6
    case wrongLoginFormat
}

extension LoginError: CustomStringConvertible {
    var description: String {
        switch self {
        case .emptyLogin: return "Пустой логин"
        case .emptyPassword: return "Пустой пароль"
        case .notAuthorized: return "Не верная пара логин/пароль"
        case .errorCreateUser: return "Ошибка создания пользователя"
        case .wrongPass: return "Не верный пароль для пользователя"
        case .passLess6: return "Пароль меньше 6 символов"
        case .wrongLoginFormat: return "Логин должен быть почтой"
        }
    }
}
