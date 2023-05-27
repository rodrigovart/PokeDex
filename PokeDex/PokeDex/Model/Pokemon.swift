//
//  Pokemon.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 06/05/23.
//

import UIKit
import MaterialColor

struct PokemonListResponse: Decodable {
    let results: [PokemonResponse]
}

struct PokemonResponse: Decodable {
    let name: String
}

struct PokemonDetailsResponse: Decodable {
    let id: Int
    let name: String
    let sprites: SpritesResponse
    let types: [TypesPokemon]
}

struct SpritesResponse: Decodable {
    let front_default: String
}

struct TypesPokemon: Decodable {
    let type: TypePokemon
}

struct TypePokemon: Decodable {
    let name: String
}

struct PokemonViewModel {
    let id: Int
    let name: String
    let imageUrl: String
    let type: PokemonType
    
    var typeColor: UIColor {
        switch type {
        case .fire:
            return MaterialColor.red.base
        case .water:
            return MaterialColor.lightBlue.dark1
        case .grass:
            return MaterialColor.green.dark1
        case .bug:
            return MaterialColor.deepPurple.dark3
        case .unknown:
            return MaterialColor.brown.light3
        }
    }
}

enum PokemonType {
    case fire
    case water
    case grass
    case bug
    case unknown
}
