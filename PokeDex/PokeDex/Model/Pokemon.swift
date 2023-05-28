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
        case .dragon:
            return MaterialColor.deepOrange.accent2
        case .psychic:
            return MaterialColor.pink.accent1
        case .electric:
            return MaterialColor.yellow.dark1
        case .rock:
            return MaterialColor.brown.dark1
        case .ice:
            return MaterialColor.lightBlue.light1
        case .fighting:
            return MaterialColor.deepOrange.accent1
        case .ground:
            return MaterialColor.brown.dark2
        case .ghost:
            return MaterialColor.deepPurple.dark1
        case .poison:
            return MaterialColor.deepPurple.light1
        case .normal:
            return MaterialColor.brown.light3
        }
    }
}

enum PokemonType: String, CaseIterable {
    case fire     = "fire"
    case water    = "water"
    case grass    = "grass"
    case bug      = "bug"
    case dragon   = "dragon"
    case psychic  = "psychic"
    case electric = "electric"
    case rock     = "rock"
    case ice      = "ice"
    case fighting = "fighting"
    case ground   = "ground"
    case ghost    = "ghost"
    case poison   = "poison"
    case normal  = "normal"
}
