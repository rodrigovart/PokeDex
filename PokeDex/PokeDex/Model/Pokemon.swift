//
//  Pokemon.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 06/05/23.
//

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let imageUrl: String
    let height: Int
    let weight: Int
    let baseExperience: Int
    let types: [PokemonType]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "sprites.front_default"
        case height
        case weight
        case baseExperience = "base_experience"
        case types
    }

    struct PokemonType: Decodable {
        let name: String
        let slot: Int
    }
    
    init(id: Int = 0, name: String = "", imageUrl: String = "", height: Int = 0, weight: Int = 0, baseExperience: Int = 0, types: [PokemonType] = []) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.height = height
        self.weight = weight
        self.baseExperience = baseExperience
        self.types = types
    }
}

struct PokemonList: Decodable {
    let count: Int
    let results: [PokemonListItem]
}

struct PokemonListItem: Decodable {
    let name: String
    let url: String
}

