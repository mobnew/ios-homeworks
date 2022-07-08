//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 01.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return profileHeaderView
    }()
    
    private lazy var tempButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.tintColor = .white
        button.setTitle("Temp button", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        navigationItem.title = "Profile"
        
        view.addSubview(profileHeaderView)
        self.view.addSubview(tempButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            tempButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            tempButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempButton.widthAnchor.constraint(equalToConstant: 200),
            tempButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
