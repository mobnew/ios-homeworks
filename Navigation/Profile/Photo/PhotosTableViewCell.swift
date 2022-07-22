//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 15.07.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let numberOfItemsInLine: CGFloat = 4
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.text = "Photos"
        
        return label
    }()
    private let arrowLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.text = "\u{2794}"
        
        return label
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileCell")
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubviews(titleLabel, arrowLabel, collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            arrowLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.25)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        PhotoStorage.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as? ProfileCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            cell.backgroundColor = .systemRed
            return cell
        }
        
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        let imageName = PhotoStorage.data[indexPath.row]
        cell.setup(with: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        
        let needwidth = collectionView.frame.width - (Constants.numberOfItemsInLine - 1) * spacing - insets.left - insets.right - 6
        let itemwidth = floor((needwidth) / Constants.numberOfItemsInLine)
        
        return CGSize(width: itemwidth, height: itemwidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        Как правильно обратиться к навигейшен контроллеру?
        print("Push")  
    }
}
