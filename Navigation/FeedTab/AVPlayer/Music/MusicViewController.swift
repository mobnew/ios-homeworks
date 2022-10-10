//
//  MusicViewController.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 06.10.2022.
//

import UIKit
import AVFoundation

struct track {
    let name: String
    let artist: String
    let trackName: AVPlayerItem
}

class MusicViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    var playerItems: [track] = []
    
//    MARK: - items
    
    private let player: AVPlayer = {
        return AVPlayer()
    }()
    
    private lazy var audioPlayerView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "nota"))
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.addArrangedSubview(backButton)
        stack.addArrangedSubview(playButton)
        stack.addArrangedSubview(stopButton)
        stack.addArrangedSubview(forwardButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(playTap), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(stopTap), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(nextTrack), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backTrack), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var songTitle: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - func
    
    @objc private func nextTrack() {
        forward()
    }
    
    @objc private func backTrack() {
        backward()
    }
    
    @objc private func playTap() {
        if player.currentItem != nil {
            if player.isPlaying { pause()
            } else { play() }
        } else {
            player.replaceCurrentItem(with: playerItems[0].trackName)
            songTitle.text = playerItems[0].artist + " - " + playerItems[0].name
            play()
        }
    }
    
    @objc private func stopTap() {
        player.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
        pause()
    }
    
    func play() {
        player.play()
        playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    func pause() {
        player.pause()
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    func forward() {
        guard let item = player.currentItem else {
            print("tracklist is empty")
            return
        }
        
        
        var index: Int = 0
        
        for (trackIndex, trackName) in playerItems.enumerated() {
            if trackName.trackName == item {
                index = trackIndex
            }
        }
        
        if index < playerItems.count - 1 {
            player.replaceCurrentItem(with: playerItems[index+1].trackName)
            songTitle.text = playerItems[index+1].artist + " - " + playerItems[index+1].name
            player.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
            play()
    } else {
        player.replaceCurrentItem(with: playerItems[0].trackName)
        songTitle.text = playerItems[0].artist + " - " + playerItems[0].name
        player.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
        play()
    }
    }
    
    func backward() {
        guard let item = player.currentItem else {
            print("tracklist is empty")
            return
        }
        
        var index: Int = 0
        
        for (trackIndex, trackName) in playerItems.enumerated() {
            if trackName.trackName == item {
                index = trackIndex
            }
        }
        
        if index < 1 {
            player.replaceCurrentItem(with: playerItems[0].trackName)
            songTitle.text = playerItems[0].artist + " - " + playerItems[0].name
            player.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
            play()
    } else {
        player.replaceCurrentItem(with: playerItems[index - 1].trackName)
        songTitle.text = playerItems[index - 1].artist + " - " + playerItems[index - 1].name
        player.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
        play()
    }
    }
    
    func addTrackToTracklist(trackNameInBundle: String, artistName: String, trackName: String) {
        let trackNameItem = AVPlayerItem(url: Bundle.main.url(forResource: trackNameInBundle, withExtension: "mp3")!)
        playerItems.append(track(name: trackName, artist: artistName, trackName: trackNameItem))
    }
    
    @objc func playerDidFinishPlaying() {
        forward()
    }
    
    @objc private func goToVideo() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        coordinator?.toVideoPlayer()
        
        
    }
    
    private func setupPlayer() {
        addTrackToTracklist(trackNameInBundle: "01", artistName: "Oxxxymiron", trackName: "Где нас нет")
        addTrackToTracklist(trackNameInBundle: "02", artistName: "Anacondaz", trackName: "Ангел")
        addTrackToTracklist(trackNameInBundle: "03", artistName: "Ария", trackName: "Штиль")
        addTrackToTracklist(trackNameInBundle: "04", artistName: "Robots Don’t Cry", trackName: "Верни мне мой 2007")
        addTrackToTracklist(trackNameInBundle: "05", artistName: "Каста", trackName: "Вокруг шум")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
    }
    
    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Video", style: .plain, target: self, action: #selector(goToVideo))
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(audioPlayerView)
        view.addSubview(stackView)
        view.addSubview(songTitle)
        
        NSLayoutConstraint.activate([
            audioPlayerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            audioPlayerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            audioPlayerView.heightAnchor.constraint(equalToConstant: 200),
            audioPlayerView.widthAnchor.constraint(equalToConstant: 200),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: audioPlayerView.bottomAnchor, constant: 100),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalToConstant: 230),
            
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.widthAnchor.constraint(equalToConstant: 50),
            
            forwardButton.heightAnchor.constraint(equalToConstant: 50),
            forwardButton.widthAnchor.constraint(equalToConstant: 50),
            
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            
            songTitle.topAnchor.constraint(equalTo: audioPlayerView.bottomAnchor, constant: 40),
            songTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            songTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
            
        ])
    }
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupPlayer()
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
