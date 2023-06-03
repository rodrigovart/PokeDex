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

struct Pokemon {
    let id: Int
    let name: String
    let imageUrl: String
    let type: [String]
}

struct PokemonViewModel {
    let id: Int
    let name: String
    let imageUrl: String
    let type: PokemonType
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
    case normal   = "normal"
    case reset  = "reset"
}
