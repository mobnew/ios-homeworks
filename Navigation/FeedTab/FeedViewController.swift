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
    
    weak var coordinator: FeedCoordinator?
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 10
        stack.toAutoLayout()
        
        return stack
    }()
    
    private lazy var button1 = CustomButton(customTitle: "Button one") {
        self.postTap()
    }
    
    private lazy var button2 = CustomButton(customTitle: "Button two") {
        self.postTap()
    }
    
    private var checkTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1
        tf.toAutoLayout()
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftViewMode = .always
        return tf
    }()
    
    private var checkLabel: UILabel = {
        let label = UILabel()
        label.text = "Wait..."
        label.toAutoLayout()
        return label
    }()
    
    private lazy var checkButton = CustomButton(customTitle: "Check") {
        guard let checkedSecret = self.checkTextField.text else { return }
        
        if !checkedSecret.isEmpty {
            if FeedModel().check(word: checkedSecret) {
                self.checkLabel.text = "Good"
                self.checkLabel.textColor = .green
            } else {
                self.checkLabel.textColor = .red
                self.checkLabel.text = "Wrong pass"
            }
        } else {
            print("Empty String")
        }
    }
    
    private lazy var avButton = CustomButton(customTitle: "AVPlayer") {
        self.goToAVPlayer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func postTap() {
        coordinator?.toPostViewController(send: post)
    }
    
    private func goToAVPlayer() {
        coordinator?.toAVPlayer()
    }
    
    private func setupSubviews() {
        view.backgroundColor = .white
        navigationItem.title = "Feed"
        
        view.addSubviews(stackView, checkTextField, checkLabel, checkButton, avButton)
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 90),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            checkTextField.widthAnchor.constraint(equalToConstant: 300),
            checkTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkTextField.heightAnchor.constraint(equalToConstant: 50),
            checkTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 35),
            
            checkLabel.topAnchor.constraint(equalTo: checkTextField.bottomAnchor,constant: 20),
            checkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            checkButton.topAnchor.constraint(equalTo: checkLabel.bottomAnchor, constant: 20),
            checkButton.heightAnchor.constraint(equalToConstant: 40),
            checkButton.widthAnchor.constraint(equalToConstant: 200),
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            avButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avButton.heightAnchor.constraint(equalToConstant: 40),
            avButton.widthAnchor.constraint(equalToConstant: 200),
            avButton.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -50)
        ])
    }
}

