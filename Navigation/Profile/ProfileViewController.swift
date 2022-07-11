//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 01.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var Cartoons: [PostCartoon] = Storage.data
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderCell")
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableCell")

        tableView.toAutoLayout()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true
        
        view.addSubviews(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Cartoons.count
    }
    
    //MARK: cell setup
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableCell", for: indexPath) as? ProfileTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
        let cartoon = Cartoons[indexPath.row]
        cell.setup(with: cartoon)
        return cell
    }
    
    //MARK: header setup
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderCell") else { return nil }
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        220
    }
    
}
