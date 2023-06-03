//
//  PokemonCollectionViewCell.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 06/05/23.
//

import UIKit
import AlamofireImage
import MaterialColor

class PokemonCollectionViewCell: UITableViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = MaterialColor.white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
    }
    
    private func configureSubviews() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(pokemonImageView)
        containerView.addSubview(nameLabel)
        
        configureConstrainsts()
    }
    
    private func configureConstrainsts() {
        containerView.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             bottom: contentView.bottomAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 8,
                             paddingLeft: 8,
                             paddingBottom: 8,
                             paddingRight: 8)
        pokemonImageView.anchor(top: containerView.topAnchor,
                                left: containerView.leftAnchor,
                                right: containerView.rightAnchor,
                                paddingTop: 8)
        nameLabel.anchor(top: pokemonImageView.bottomAnchor,
                         left: containerView.leftAnchor,
                         bottom: containerView.bottomAnchor,
                         right: containerView.rightAnchor,
                         paddingBottom: 8)
    }
    
    func configure(with pokemon: PokemonViewModel) {
        nameLabel.text = pokemon.name.capitalized
        containerView.backgroundColor = pokemon.typeColor
        
        if let url = URL(string: pokemon.imageUrl) {
            pokemonImageView.af.setImage(withURL: url)
        }
    }
}
