//
//  FeedViewController.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 01.07.2022.
//

import UIKit

class FeedViewController: UIViewController {
    let post: Post = Post(title: "New title")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Feed"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postTap))
    }
    
    @objc private func postTap() {
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
}

