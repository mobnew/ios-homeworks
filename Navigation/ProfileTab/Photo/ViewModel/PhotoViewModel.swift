//
//  PhotoViewModel.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 16.09.2022.
//

import Foundation

final class PhotoViewModel {
    var ImagesArray: [String]
    
    var ImageNames: [String]? {
        didSet {
            self.imageNameDidChenge?(self)
        }
    }
    
    init(model: [String]) {
        self.ImagesArray = model
    }
    
    var imageNameDidChenge: ((PhotoViewModel) -> ())?
    
    func showMagic() {
        ImageNames = ImagesArray
    }
}
