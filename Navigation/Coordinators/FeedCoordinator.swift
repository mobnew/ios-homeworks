//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 13.09.2022.
//

import UIKit
import StorageService

class FeedCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedVC = FeedViewController()
        feedVC.coordinator = self
        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "square.grid.3x3.topright.fill")
        navigationController.pushViewController(feedVC, animated: false)
    }
    
    func toPostViewController(send post: Post) {
        let postVC = PostViewController()
        postVC.post = post
        navigationController.pushViewController(postVC, animated: true)
    }
    
    func toAVPlayer() {
        let avPlayerVC = MusicViewController()
        avPlayerVC.coordinator = self
        navigationController.pushViewController(avPlayerVC, animated: true)
    }
    
    func toVideoPlayer() {
        let videoPlayerVC = VideoViewController()
        videoPlayerVC.coordinator = self
        navigationController.pushViewController(videoPlayerVC, animated: true)
    }
    
    func toRecorder() {
        let recorderVC = RecorderViewController()
        recorderVC.coordinator = self
        navigationController.pushViewController(recorderVC, animated: true)
    }
    
    func toInfoVC() {
        let infoVC = InfoViewController()
        infoVC.coordinator = self
        navigationController.pushViewController(infoVC, animated: true)
    }
}
