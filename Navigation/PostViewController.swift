//
//  PostViewController.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 01.07.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        title = post?.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddModal))
    }
    
    
    @objc private func tapAddModal() {
        present(InfoViewController(), animated: true, completion: nil)
    }
}
