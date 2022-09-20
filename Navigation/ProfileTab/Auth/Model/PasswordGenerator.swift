//
//  Brutforce.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 20.09.2022.
//

import Foundation


struct PasswordGenerator {
var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
var letters:     String { return lowercase + uppercase }

    func getRandomPass(characterSet: String, passLength: Int) -> String {
        let characters: [String] = characterSet.map { String($0) }
        var randomPass = ""
        for _ in 1...passLength {
            randomPass += characters.randomElement()!
        }
        
        return randomPass
    }
}
