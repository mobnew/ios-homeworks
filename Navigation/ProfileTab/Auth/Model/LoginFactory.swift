//
//  LoginFactory.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 27.08.2022.
//

import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
