//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 16.09.2022.
//

import Foundation
import StorageService

class ProfileViewModel {
    var cartoons: [PostCartoon]?
    var oneMoreTmpUser: User?
    
    var user: User? {
        didSet {
            self.userDidChange?(self)
        }
    }
    
    var userDidChange: ((ProfileViewModel) -> ())?
    
    init(userfromLogin: User, cartoons: [PostCartoon]) {
        self.oneMoreTmpUser = userfromLogin
        self.cartoons = cartoons
    }
    
    func getData() {
        user = oneMoreTmpUser
    }
}
