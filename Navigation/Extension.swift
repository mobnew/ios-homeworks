//
//  extention.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 11.07.2022.
//

import UIKit

public extension UIView {
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
