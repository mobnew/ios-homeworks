//
//  ProfileTableHederView.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 11.07.2022.
//

import UIKit
import SnapKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private var statusText: String = ""
    
    private lazy var profileHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.toAutoLayout()
        return view
    }()
    
    let avatarImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "h2"))
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.isUserInteractionEnabled = true
        image.toAutoLayout()
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Homer"
        label.toAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.setTitle("Set status", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.toAutoLayout()
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = UIColor.black
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.toAutoLayout()
        return textField
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(profileHeaderView)
        profileHeaderView.addSubviews(avatarImageView, nameLabel, statusButton,statusLabel, statusTextField)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius =  avatarImageView.frame.width / 2
    }
    
    @objc private func buttonPress() {
        guard let status = statusTextField.text else { return }
        statusLabel.text = status
        
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        guard let statusText = textField.text else { return }
        print(statusText)
    }
    
    private func setupConstraints() {
        profileHeaderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalTo(16)
            make.left.equalTo(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(27)
            make.left.equalTo(avatarImageView.snp.right).offset(16)
        }
        
        statusButton.snp.makeConstraints { make in
            make.size.height.equalTo(50)
            make.left.equalTo(16)
            make.right.bottom.equalTo(-16)
            make.top.equalTo(avatarImageView.snp.bottom).offset(36)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalTo(-16)
            make.bottom.equalTo(statusButton.snp.top).offset(-20)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.bottom.equalTo(statusTextField.snp.top).offset(-16)
        }
    }
}
