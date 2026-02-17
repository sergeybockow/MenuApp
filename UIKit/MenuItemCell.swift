//
//  ItemCell.swift
//  Menu
//
//  Created by Vadim Chistiakov on 19.01.2026.
//  Copyright © 2026 DoorDash, Inc. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3 // important!!
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        [titleLabel, iconImageView].forEach { $0.isHidden = false }
    }
    
    private func setupUI() {
        let verticalStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        verticalStack.axis = .vertical
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalStack = UIStackView(arrangedSubviews: [verticalStack, iconImageView])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 16
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(horizontalStack)
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            horizontalStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 21),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            iconImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    func configure(with model: ContentItem) {
        self.titleLabel.text = model.title
        self.titleLabel.isHidden = (model.title == nil)
        
        self.descriptionLabel.text = model.description
        loadImage(with: model.imageUrl) { [weak self] image in
            DispatchQueue.main.async {
                if let image {
                    self?.iconImageView.image = image
                    self?.iconImageView.isHidden = false
                } else {
                    self?.iconImageView.isHidden = true
                }
            }
        }
    }
    
    private func loadImage(with imageURL: String?, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageURL,
                  let url = URL(string: imageURL),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else {
                completion(nil)
                return
            }
            completion(image)
        }
    }
}
