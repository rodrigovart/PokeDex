//
//  String+Ext.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 27/05/23.
//

import UIKit
import MaterialColor

extension String {
    func toPokemonTypeColor() -> UIColor {
        switch self {
        case "fire":
            return MaterialColor.red.base
        case "water":
            return MaterialColor.lightBlue.dark1
        case "grass":
            return MaterialColor.green.dark1
        case "bug":
            return MaterialColor.deepPurple.dark3
        case "dragon":
            return MaterialColor.deepOrange.accent2
        case "psychic":
            return MaterialColor.pink.light1
        case "electric":
            return MaterialColor.yellow.dark1
        case "rock":
            return MaterialColor.brown.dark3
        case "ice":
            return MaterialColor.lightBlue.light1
        case "fighting":
            return MaterialColor.deepOrange.accent1
        case "ground":
            return MaterialColor.brown.dark1
        case "ghost":
            return MaterialColor.deepPurple.dark1
        case "poison":
            return MaterialColor.deepPurple.light1
        case "flying":
            return MaterialColor.orange.dark4
        case "fairy":
            return MaterialColor.pink.accent1
        case "steel":
            return MaterialColor.darkGray
        case "reset":
            return MaterialColor.black
        case "normal":
            return MaterialColor.brown.light3
        default:
            return MaterialColor.brown.light3
        }
    }
    
    func toPokemonType() -> PokemonType {
        switch self {
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
        case "flying":
            return .flying
        case "fairy":
            return .fairy
        case "steel":
            return .steel
        case "normal":
              return .normal
        default:
            return .reset
        }
    }
}
