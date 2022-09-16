//
//  PhotoViewModel.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 16.09.2022.
//

import Foundation

protocol PhotoViewModelProtocol: AnyObject {
    
    var ImageNames: [String]? { get }
    var imageNameDidChenge: ((PhotoViewModelProtocol) -> ())? { get set }
    
    func showMagic()
}

final class PhotoViewModel: PhotoViewModelProtocol {
    var ImagesArray: [String]
    
    var ImageNames: [String]? {
        didSet {
            self.imageNameDidChenge?(self)
        }
    }
    
    init(model: [String]) {
        self.ImagesArray = model
    }
    
    var imageNameDidChenge: ((PhotoViewModelProtocol) -> ())?
    
    func showMagic() {
        ImageNames = ImagesArray
    }
}
