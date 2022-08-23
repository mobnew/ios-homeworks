//
//  FeedViewController.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 01.07.2022.
//


import UIKit
import StorageService

class FeedViewController: UIViewController {
    var post: Post = Post(title: "New title")
    
    
    private lazy var stackView: UIStackView = {
       let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 10
        stack.toAutoLayout()
        
        return stack
    }()
    
    private lazy var button1: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemYellow
        button.tintColor = .white
        button.setTitle("Button one", for: .normal)
        button.addTarget(self, action: #selector(postTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var button2: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemYellow
        button.tintColor = .white
        button.setTitle("Button two", for: .normal)
        button.addTarget(self, action: #selector(postTap), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    @objc private func postTap() {
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    private func setupSubviews() {
        view.backgroundColor = .white
        navigationItem.title = "Feed"
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 90),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

