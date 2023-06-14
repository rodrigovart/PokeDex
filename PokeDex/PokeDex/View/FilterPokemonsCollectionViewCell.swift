//
//  FilterPokemonsCollectionViewCell.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 27/05/23.
//

import UIKit
import MaterialColor

class FilterPokemonsCollectionViewCell: UICollectionViewCell {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.textColor = MaterialColor.white
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
    
    
    func configure(text: String) {
        backgroundColor = text.toPokemonTypeColor()
        contentView.addSubview(label)
        label.text = text.capitalized
        label.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
