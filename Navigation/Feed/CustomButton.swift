//
//  CustomButton.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 08.09.2022.
//

import UIKit


class CustomButton: UIButton {
    private let tapClosure: (() -> ())
    
    init(customTitle: String,
         closure: @escaping (() -> ())) {
        
        self.tapClosure = closure
        super.init(frame: .zero)
        
        setTitle(customTitle, for: .normal)
        tintColor = .white
        backgroundColor = .systemYellow
        toAutoLayout()

        addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    @objc private func tap() {
       tapClosure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
