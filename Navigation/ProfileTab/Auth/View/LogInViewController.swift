//
//  LogInViewController.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 08.07.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    
    var viewModel: LoginViewModel! {
        didSet {
            self.viewModel.checkerIsLaunched = { [ weak self ] viewModel in
                if let err = viewModel.loginError  {
                    if err == .wrongPass {
                        self?.showAlert(message: "\(err.description) \(self!.emailTextField.text!)")
                        return
                    } else {
                        self?.showAlert(message: err.description)
                        return
                    }
                }
                
                guard let resultUser = viewModel.loginedUser else {
                   preconditionFailure("nil User")
                }
                self?.coordinator?.toProfileViewController(with: resultUser)
            }
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.toAutoLayout()
        scroll.addSubviews(logoImageView)
        scroll.addSubviews(emailPassContainer)
        scroll.addSubviews(loginButton)
        return scroll
    }()
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.toAutoLayout()
        return image
    }()
    
    private lazy var emailPassContainer: UIStackView = {
        let stack = UIStackView()
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        stack.axis = .vertical
        stack.backgroundColor = .lightGray
        stack.toAutoLayout()
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(separator)
        stack.addArrangedSubview(passTextField)
        return stack
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor(named: "ColorSet")
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.placeholder = "Email or phone"
        return textField
    }()
    
    private lazy var passTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor(named: "ColorSet")
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        return textField
    }()
    
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.layer.borderColor = UIColor.lightGray.cgColor
        separator.layer.borderWidth = 0.25
        separator.toAutoLayout()
        return separator
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.alpha = (button.state == .normal) ? 1 : 0.8
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupGuestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forcedHidingKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupSubviews() {
        setupGuestures()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            emailPassContainer.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            emailPassContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailPassContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailPassContainer.heightAnchor.constraint(equalToConstant: 100),
            
            loginButton.topAnchor.constraint(equalTo: emailPassContainer.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: emailPassContainer.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailPassContainer.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            separator.centerYAnchor.constraint(equalTo: emailPassContainer.centerYAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let loginButtonBottomPointY = loginButton.frame.origin.y + loginButton.frame.height + 16
            
            let keyboardOriginY = view.frame.height - keyboardHeight
            let yOffset = keyboardOriginY < loginButtonBottomPointY ? loginButtonBottomPointY - keyboardOriginY + 16 : 0
            
            scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        forcedHidingKeyboard()
    }
    
    @objc private func forcedHidingKeyboard() {
        view.endEditing(true)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc private func tapButton() {
        view.endEditing(true)
        
        do {
          try viewModel.startChecker(login: emailTextField.text!, pass: passTextField.text!)
        } catch LoginError.emptyLogin {
            showAlert(message: LoginError.emptyLogin.description)
        } catch LoginError.emptyPassword {
            showAlert(message: LoginError.emptyPassword.description)
        } catch {}
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
