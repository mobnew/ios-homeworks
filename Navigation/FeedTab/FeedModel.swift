//
//  FeedModel.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 08.09.2022.
//

import Foundation

class FeedModel {
    private let secret = "Ddd"
    
    func check(word: String) -> Bool {
         word == secret 
    }
}
