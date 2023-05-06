//
//  PokemonCell.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 06/05/23.
//

import UIKit
import SDWebImage

class PokemonCell: UICollectionViewCell {

    // MARK: - Properties

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = .darkGray
        contentView.addSubview(nameLabel)
        return nameLabel
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name
        if let imageUrl = URL(string: pokemon.imageUrl) {
            imageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }

    // MARK: - Layout

    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
}

