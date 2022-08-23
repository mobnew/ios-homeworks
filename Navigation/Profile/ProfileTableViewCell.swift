//
//  ProfileTableViewCell.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 11.07.2022.
//

import UIKit
import StorageService

class ProfileTableViewCell: UITableViewCell {
    
    private let cartoonTitleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 2
        
        
        return label
    }()
    
    private let cartoonImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.toAutoLayout()
        return image
    }()
    
    private let cartoonDescriptionLabel : UILabel = {
        let description = UILabel()
        description.font = UIFont.systemFont(ofSize: 14)
        description.toAutoLayout()
        description.numberOfLines = 0
        description.textColor = .systemGray
        return description
    }()
    
    private let likesLabel : UILabel = {
        let likes = UILabel()
        likes.toAutoLayout()
        likes.font = UIFont.systemFont(ofSize: 16)
        likes.textColor = .black
        
        return likes
    }()
    
    private let viewsLabel : UILabel = {
        let views = UILabel()
        views.toAutoLayout()
        views.font = UIFont.systemFont(ofSize: 16)
        views.textColor = .black
        
        return views
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubviews(cartoonTitleLabel, cartoonImageView,cartoonDescriptionLabel, likesLabel, viewsLabel)
        
        NSLayoutConstraint.activate([
            cartoonTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cartoonTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cartoonTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            cartoonImageView.topAnchor.constraint(equalTo: cartoonTitleLabel.bottomAnchor, constant: 16),
            cartoonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cartoonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cartoonImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            cartoonImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            cartoonDescriptionLabel.topAnchor.constraint(equalTo: cartoonImageView.bottomAnchor, constant: 16),
            cartoonDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            cartoonDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: cartoonDescriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            viewsLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cartoonTitleLabel.text = nil
        cartoonImageView.image = nil
        cartoonDescriptionLabel.text = nil
        likesLabel.text = nil
        viewsLabel.text = nil
    }
    
    func setup(with cartoon: PostCartoon) {
        cartoonTitleLabel.text = cartoon.author
        cartoonImageView.image = UIImage(named: cartoon.image)
        cartoonDescriptionLabel.text = cartoon.description
        likesLabel.text = String("Likes: \(cartoon.likes)")
        viewsLabel.text = String("Views: \(cartoon.views)")
    }
}
