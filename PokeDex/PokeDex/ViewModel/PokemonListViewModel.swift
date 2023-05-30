//
//  PokemonListViewModel.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 06/05/23.
//

import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class PokemonListViewModel {
    
    private let apiUrl = "https://pokeapi.co/api/v2/pokemon?limit=151"
    private let apiUrlDetail = "https://pokeapi.co/api/v2/pokemon"

    let pokemonList = BehaviorSubject<[PokemonViewModel]>(value: [])
    var pokemonListValue: [PokemonViewModel] {
        do {
            return try pokemonList.value()
        } catch {
            print("Error accessing pokemonList value: \(error)")
            return []
        }
    }
    
    func loadPokemonData() {
           AF.request(apiUrl).responseDecodable(of: PokemonListResponse.self) { [weak self] response in
               guard let self = self else { return }

               switch response.result {
               case .success(let pokemonListResponse):
                   let pokemonNames = pokemonListResponse.results.compactMap { $0.name }
                   self.fetchPokemonDetails(pokemonNames: pokemonNames)
               case .failure(let error):
                   print("Error fetching pokemon data: \(error)")
               }
           }
       }

       private func fetchPokemonDetails(pokemonNames: [String]) {
           let fetchGroup = DispatchGroup()
           var pokemonViewModels: [PokemonViewModel] = []

           for name in pokemonNames {
               fetchGroup.enter()

               let pokemonUrl = "\(apiUrlDetail)/\(name)"
               AF.request(pokemonUrl).responseDecodable(of: PokemonDetailsResponse.self) { [weak self] response in
                   guard let self = self else { return }

                   switch response.result {
                   case .success(let pokemonDetailsResponse):
                       dump(pokemonDetailsResponse)
                       let type: PokemonType = self.getPokemonType(for: pokemonDetailsResponse.types.first)
                       let pokemonViewModel = PokemonViewModel(id: pokemonDetailsResponse.id,
                                                               name: pokemonDetailsResponse.name,
                                                               imageUrl: pokemonDetailsResponse.sprites.front_default,
                                                               type: type)
                       pokemonViewModels.append(pokemonViewModel)
                   case .failure(let error):
                       print("Error fetching pokemon details: \(error)")
                   }

                   fetchGroup.leave()
               }
           }

           fetchGroup.notify(queue: .main) { [weak self] in
               guard let self else { return }
               pokemonViewModels.sort { $0.id < $1.id }
               self.pokemonList.onNext(pokemonViewModels)
           }
       }
    
    private func getPokemonType(for type: TypesPokemon?) -> PokemonType {
        guard let type else { return .normal }
        let lowercaseName = type.type.name

            switch lowercaseName {
            case "fire":
                return .fire
            case "water":
                return .water
            case "grass":
                return .grass
            case "bug":
                return .bug
            case "dragon":
                return .dragon
            case "psychic":
                return .psychic
            case "electric":
                return .electric
            case "rock":
                return .rock
            case "ice":
                return .ice
            case "fighting":
                return .fighting
            case "ground":
                return .ground
            case "ghost":
                return .ghost
            case "poison":
                return .poison
            default:
                return .normal
            }
    }
}
