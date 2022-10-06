//
//  VideoViewController.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 06.10.2022.
//

import UIKit
import AVFoundation

struct videoItem {
    let title: String
    let link: String
}

class VideoViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    private var list = [videoItem]()
    
    private let playerVideo: AVPlayer = {
        return AVPlayer()
    }()
    
    private lazy var playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer(player: playerVideo)
        
        return layer
    }()
    
    private lazy var playerView: UIView = {
       let view = UIView()
        
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.addSublayer(playerLayer)
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = playerView.bounds
    }
    
    @objc private func goToRecorder() {
        playerVideo.pause()
        coordinator?.toRecorder()
    }
    
    private func startVideo(numberOfVideo: Int) {
        playerVideo.replaceCurrentItem(with: AVPlayerItem(url: URL(string: list[numberOfVideo].link)!))
        playerVideo.play()
    }
    
    private func addVideoItems() {
        list.append(videoItem(title: "Big Buck Bunny", link: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"))
        list.append(videoItem(title: "Elephants Dream", link: "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"))
        list.append(videoItem(title: "For Bigger Blazes", link: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"))
        list.append(videoItem(title: "For Bigger Escapes", link: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"))
    }
    
    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Recorder", style: .plain, target: self, action: #selector(goToRecorder))
        
        view.backgroundColor = .systemBackground
        view.addSubview(playerView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.625),
            
            tableView.topAnchor.constraint(equalTo: playerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addVideoItems()
    }
}


extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        cell.textLabel?.text = list[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playerVideo.pause()
        startVideo(numberOfVideo: indexPath.row)
    }
}
