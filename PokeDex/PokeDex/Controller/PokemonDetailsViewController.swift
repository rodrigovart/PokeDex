//
//  PokemonDetailsViewController.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 05/06/23.
//

import UIKit
import AlamofireImage

class PokemonDetailsViewController: UIViewController {
    
    var pokemon: PokemonViewModel?
    
    private lazy var pokemonView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadPokemonDetail()
    }
    
    func loadPokemonDetail() {
        guard var pokemon = self.pokemon else { return }
        title = pokemon.name.capitalized
        if let url = URL(string: pokemon.imageUrl) {
            pokemonImageView.af.setImage(withURL: url)
        }
        view.addSubview(pokemonView)
        pokemonView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           left: view.leftAnchor,
                           right: view.rightAnchor,
                           paddingLeft: 60,
                           paddingRight: 60,
                           height: 250)
        pokemonView.addSubview(pokemonImageView)
        pokemonImageView.center(inView: pokemonView)
        pokemonView.layer.cornerRadius = 130
        pokemonView.backgroundColor = pokemon.type.first?.rawValue.toPokemonTypeColor()
    }
}
