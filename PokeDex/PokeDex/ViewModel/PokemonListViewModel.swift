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
import ProgressHUD
import SwiftMessages

class PokemonListViewModel {
    
    private let apiUrl = "https://pokeapi.co/api/v2/pokemon?limit=151"
    private let apiUrlDetail = "https://pokeapi.co/api/v2/pokemon"
    
    lazy var error: MessageView = {
        let error = MessageView.viewFromNib(layout: .tabView)
        error.configureTheme(.error)
        error.configureContent(title: "Erro", body: "")
        error.button?.setTitle("Fechar", for: .normal)
        return error
    }()
    
    let pokemonList = BehaviorSubject<[PokemonViewModel]>(value: [])
    var pokemonListValue: [PokemonViewModel] {
        do {
            return try pokemonList.value()
        } catch {
            self.error.configureContent(body: error.localizedDescription)
            SwiftMessages.show(view: self.error)
            return []
        }
    }
    
    func loadPokemonData() {
        ProgressHUD.show()
        AF.request(apiUrl).responseDecodable(of: PokemonListResponse.self) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let pokemonListResponse):
                let pokemonNames = pokemonListResponse.results.compactMap { $0.name }
                self.fetchPokemonDetails(pokemonNames: pokemonNames)
            case .failure(let error):
                self.error.configureContent(body: error.localizedDescription)
                SwiftMessages.show(view: self.error)
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
                case .success(let result):
                    let type: [PokemonType] = self.getPokemonType(for: result.types)
                    let pokemonViewModel = PokemonViewModel(id: result.id,
                                                            name: result.name,
                                                            imageUrl: result.sprites.front_default,
                                                            type: type)
                    pokemonViewModels.append(pokemonViewModel)
                case .failure(let error):
                    self.error.configureContent(body: error.localizedDescription)
                    SwiftMessages.show(view: self.error)
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

    private func getPokemonType(for typesPokemon: [TypesPokemon]) -> [PokemonType] {
        var types: [PokemonType] = []
        
        for type in typesPokemon {
            types.append(type.type.name.toPokemonType())
        }
        
        return types
    }
}
