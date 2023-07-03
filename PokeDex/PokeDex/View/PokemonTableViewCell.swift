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
    private lazy var stackViewContent: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.backgroundColor = .red
        stack.spacing = 8.0
        stack.layer.cornerRadius = 8
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOffset = CGSize(width: 0, height: 2)
        stack.layer.shadowRadius = 4
        stack.layer.shadowOpacity = 0.2
        stack.anchor(height: 200)
        return stack
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(height: 100)
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = MaterialColor.white
        label.anchor(height: 20)
        return label
    }()
    
    private lazy var tagStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 5.0
        stack.anchor(width: 80, height: 40)
        return stack
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
        contentView.addSubview(stackViewContent)
        stackViewContent.addArrangedSubview(pokemonImageView)
        stackViewContent.addArrangedSubview(nameLabel)

        configureConstrainsts()
    }
    
    private func configureConstrainsts() {
        stackViewContent.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             bottom: contentView.bottomAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 8,
                             paddingLeft: 8,
                             paddingBottom: 8,
                             paddingRight: 8)
    }
    
    func configure(with pokemon: PokemonViewModel) {
        nameLabel.text = pokemon.name.capitalized
        makeTags(types: pokemon.type)
        stackViewContent.backgroundColor = MaterialColor.lightGray
        
        if let url = URL(string: pokemon.imageUrl) {
            pokemonImageView.af.setImage(withURL: url)
        }
    }
    
    private func makeTags(types: [PokemonType]) {
        tagStackView.removeFullyAllArrangedSubviews()
        tagStackView.addArrangedSubview(UIView())
        
        for type in types {
            let tag = TagType()
            tag.configure(text: type.rawValue)
            tagStackView.addArrangedSubview(tag)
            tagStackView.addArrangedSubview(UIView())
        }
        
        stackViewContent.addArrangedSubview(tagStackView)
    }
}
