//
//  InfoViewController.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 01.07.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.frame = CGRect(x: 150, y: 200, width: 150, height: 50)
        button.setTitle("Show Alert", for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupSubviews()
    }
    
    private func setupSubviews() {
        view.backgroundColor = .systemGray
        view.addSubview(alertButton)
    }
    
    @objc private func showAlert() {
        let alert = UIAlertController(title: "Заданный title", message: "Заданный message", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Да", style: .destructive, handler: {_ in
            print("Yes")
        })
        
        let noAction = UIAlertAction(title: "Нет", style: .cancel, handler: {_ in
            print("No")
        })
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
}
