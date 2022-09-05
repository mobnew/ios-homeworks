//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 15.07.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private var recivedImages: [UIImage] = []
    private let imageFasade = ImagePublisherFacade()
    
    private enum Constants {
        static let numberOfItemsInLine: CGFloat = 3
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        imageFasade.removeSubscription(for: self)
    }
    
    private func setupObserver() {
        var array2: [UIImage] = []
        imageFasade.subscribe(self)
        PhotoStorage.data.forEach { i in
            array2.append(UIImage(named: i)!)
        }
        imageFasade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: array2)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = false
        title = "Photo Gallery"
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            cell.clipsToBounds = true
            cell.backgroundColor = .systemRed
            return cell
        }
        
        cell.clipsToBounds = true
        let imageName = recivedImages[indexPath.row]
        cell.setup(with: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recivedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        
        let needwidth = collectionView.frame.width - (Constants.numberOfItemsInLine - 1) * spacing - insets.left - insets.right
        let itemwidth = floor((needwidth) / Constants.numberOfItemsInLine)
        
        return CGSize(width: itemwidth, height: itemwidth)
    }
}


extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        recivedImages = images
        collectionView.reloadData()
    }
}
