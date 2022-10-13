//
//  InfoViewController.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 01.07.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
    private lazy var peopleArray: [String] = []
    
    private lazy var task1Label: UILabel = {
        let label = UILabel()
        label.text = "Task 1"
        label.textAlignment = .center
        label.numberOfLines = 0
        
        label.toAutoLayout()
        return label
    }()
    
    private lazy var task2Label: UILabel = {
        let label = UILabel()
        label.text = "Task 2"
        label.textAlignment = .center
        label.numberOfLines = 0
        
        label.toAutoLayout()
        return label
    }()
    
    private lazy var peopleTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.toAutoLayout()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
        ///Task 1
        getTODOItem { todoItemTitle in
            guard let todoItemTitle else { return }
            DispatchQueue.main.async {
                self.task1Label.text = todoItemTitle
            }
        }
        
        ///Task 2
        getPlanetDayLength { planetItem in
            guard let planetItem else { return }
            DispatchQueue.main.async {
                self.task2Label.text = planetItem.dayLength
            }
        }
        
        ///Task 3
        getPlanetDayLength { planetItem in
            guard let planetItem else { return }
            
            planetItem.residents.forEach { myURL in
                getPlanetResidentName(peopleURL: myURL) { peopleName in
                    self.peopleArray.append(peopleName!.name)
                    DispatchQueue.main.async {
                        self.peopleTable.reloadData()
                    }
                }
            }
        }
    }
    
    private func setupSubviews() {
        view.backgroundColor = .systemBackground
        title = "InfoViewController"
        
        view.addSubview(task1Label)
        view.addSubview(task2Label)
        view.addSubview(peopleTable)
        
        NSLayoutConstraint.activate([
            task1Label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            task1Label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            task1Label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            
            task2Label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            task2Label.topAnchor.constraint(equalTo: task1Label.bottomAnchor, constant: 25),
            task2Label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            
            peopleTable.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            peopleTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            peopleTable.topAnchor.constraint(equalTo: task2Label.bottomAnchor, constant: 10),
            peopleTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = peopleArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
}
