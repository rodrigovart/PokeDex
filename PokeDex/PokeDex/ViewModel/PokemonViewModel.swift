//
//  PokemonViewModel.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 06/05/23.
//

import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class PokemonViewModel {

    private let apiUrl = "https://pokeapi.co/api/v2/pokemon"
    private let disposeBag = DisposeBag()

    private var pokemonArray: [Pokemon] = []
    let pokemon = PublishSubject<[Pokemon]>()

    func fetchPokemon() {
        AF.request(apiUrl).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (_, subJson):(String, JSON) in json["results"] {
                    let name = subJson["name"].stringValue
                    let imageUrl = subJson["url"].stringValue
                    let pokemon = Pokemon()
                    self?.pokemonArray.append(pokemon)
                }
                self?.pokemon.onNext(self?.pokemonArray ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
}

