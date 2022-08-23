//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 01.07.2022.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    private var Cartoons: [PostCartoon] = Storage.data
    private var startPoint: CGPoint? = nil
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderCell")
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableCell")
        
        tableView.toAutoLayout()
        return tableView
    }()
    
    private lazy var transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0
        view.toAutoLayout()
        return view
    }()
    
    private lazy var secondAvatarImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "h2"))
        image.alpha = 0
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.toAutoLayout()
        image.clipsToBounds = true
        
        return image
    }()
    
    var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(closeTap), for: .touchUpInside)
        button.alpha = 0
        button.toAutoLayout()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        #if DEBUG
        view.backgroundColor = .lightGray
        #else
        view.backgroundColor = .systemPink
        #endif
        
        view.addSubviews(tableView, transparentView, secondAvatarImageView, closeButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            transparentView.topAnchor.constraint(equalTo: view.topAnchor),
            transparentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            transparentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            transparentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            secondAvatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            secondAvatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondAvatarImageView.heightAnchor.constraint(equalToConstant: 100),
            secondAvatarImageView.widthAnchor.constraint(equalToConstant: 100),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func closeTap() {
        guard let startPoint = startPoint else { return }
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: .curveLinear) {
            self.closeButton.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: .curveLinear) {
                self.secondAvatarImageView.transform = .identity
                self.secondAvatarImageView.center = startPoint
                self.secondAvatarImageView.layer.cornerRadius = self.secondAvatarImageView.frame.size.width / 2
                self.transparentView.alpha = 0
            } completion: { _ in
                self.secondAvatarImageView.alpha = 0
            }
        }
    }
    
    @objc private func tap() {
        startPoint = self.secondAvatarImageView.center
        
        secondAvatarImageView.layer.cornerRadius = self.secondAvatarImageView.frame.size.width / 2
        secondAvatarImageView.alpha = 1
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .curveLinear) {
            self.transparentView.alpha = 0.5
            self.secondAvatarImageView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
            self.secondAvatarImageView.transform = CGAffineTransform(scaleX: self.view.frame.width / 100, y: self.view.frame.width / 100)
            self.secondAvatarImageView.layer.cornerRadius = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           options: .curveLinear) {
                self.closeButton.alpha = 1
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : Cartoons.count
    }
    
    //MARK: cell setup
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableCell", for: indexPath) as? ProfileTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            
            let cartoon = Cartoons[indexPath.row]
            cell.setup(with: cartoon)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            return cell
        }
    }
    
    //MARK: header setup
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderCell") as? ProfileTableHeaderView else { return nil }
            
            let tapAvatar = UITapGestureRecognizer(target: self, action: #selector(tap))
            headerCell.avatarImageView.addGestureRecognizer(tapAvatar)
            
            return headerCell
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) && (indexPath.row == 0) {
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        }
    }
}
