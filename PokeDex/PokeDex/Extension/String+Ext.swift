//
//  String+Ext.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 25/05/23.
//

import UIKit

extension String {
    func toPokemonType() -> PokemonType? {
        switch self {
        case "fire":
            return .fire
        case "water":
            return .water
        case "grass":
            return .grass
        // Add more cases for other types
        default:
            return nil
        }
    }
}
