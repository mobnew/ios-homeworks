//
//  Checker.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 25.08.2022.
//

import Foundation

class Checker {
    static var shared = Checker()
    
    private let login: String = "rr"
    private let pass: String = "qq"
    
    func check(login: String, pass: String) -> Bool {
        return true
    }
}
