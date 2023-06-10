//
//  TagType.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 03/06/23.
//

import UIKit
import MaterialColor

class TagType: UIView {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.textColor = MaterialColor.white
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    
    func configure(text: String) {
        backgroundColor = text.toPokemonTypeColor()
        addSubview(label)
        label.text = text.capitalized
        label.anchor(top: topAnchor,
                     left: leftAnchor,
                     bottom: bottomAnchor,
                     right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
