//
//  ViewController.swift
//  FileManaget_HW
//
//  Created by Alexey Kurazhov on 08.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var listDir = [contentStruct]()
    let serviceFM = FileManagerService()
    
    lazy var localCrurrentPath: String = PathFinder.shared.currentPath
    
    
    private lazy var tableForFiles: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    private func reloadDataInTable() {
        listDir = serviceFM.contentOfDirectory(subDirectory: localCrurrentPath)
        tableForFiles.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if PathFinder.shared.currentPath == localCrurrentPath {
            let laststr = PathFinder.shared.currentPath.components(separatedBy: "/").last
            PathFinder.shared.currentPath.removeLast(laststr!.count + 1)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableForFiles)
        NSLayoutConstraint.activate([
            tableForFiles.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableForFiles.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableForFiles.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableForFiles.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let addFolder = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(addFolder))
        let addFile = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFileFromPicker))
        navigationItem.rightBarButtonItems = [ addFile, addFolder]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listDir = serviceFM.contentOfDirectory(subDirectory: localCrurrentPath)
        title = PathFinder.shared.currentPath.components(separatedBy: "/").last
        
        setupViews()
    }
    
    @objc private func addFileFromPicker() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func addFolder() {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add folder", message: "Enter folder name:", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Folder name"
            textField = alertTextField
        }
        
        let actionCreate = UIAlertAction(title: "Create", style: .default) { action in
            let newDir = self.localCrurrentPath + "/" + textField.text!
            self.serviceFM.createDirectory(subDirectory: newDir)
            self.reloadDataInTable()
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(actionCreate)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listDir.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = listDir[indexPath.row].name
        if listDir[indexPath.row].isDir {
            cell.accessoryType = .disclosureIndicator
        }
        cell.selectionStyle = .none
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listDir[indexPath.row].isDir {
            PathFinder.shared.currentPath = PathFinder.shared.currentPath + "/" + listDir[indexPath.row].name
            navigationController?.pushViewController(ViewController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            serviceFM.removeContent(delitingItem: URL(filePath: localCrurrentPath + "/" + listDir[indexPath.row].name))
            reloadDataInTable()
        }
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        serviceFM.createFile(filePath: URL(filePath: localCrurrentPath), image: image)
        dismiss(animated: true)
        reloadDataInTable()
    }
}
