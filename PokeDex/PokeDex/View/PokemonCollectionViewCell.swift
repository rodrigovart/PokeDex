//
//  PokemonCollectionViewCell.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 06/05/23.
//

import UIKit
import AlamofireImage
import MaterialColor

class PokemonCollectionViewCell: UICollectionViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
    }
    
    private func configureSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(pokemonImageView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            pokemonImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            pokemonImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            pokemonImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            pokemonImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            pokemonImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1),
        ])
    }
    
    func configure(with pokemon: PokemonViewModel) {
        containerView.backgroundColor = pokemon.typeColor
        
        if let url = URL(string: pokemon.imageUrl) {
            pokemonImageView.af.setImage(withURL: url)
        }
    }
}
