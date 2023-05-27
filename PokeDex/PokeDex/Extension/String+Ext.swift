//
//  String+Ext.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 27/05/23.
//

import UIKit
import MaterialColor

extension String {
    func toPokemonType() -> UIColor {
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
            return MaterialColor.pink.accent1
        case "electric":
            return MaterialColor.brown.dark3
        case "rock":
            return MaterialColor.brown.dark3
        case "ice":
            return MaterialColor.lightBlue.light1
        case "fighting":
            return MaterialColor.deepOrange.accent1
        case "ground":
            return MaterialColor.brown.dark2
        case "ghost":
            return MaterialColor.deepPurple.dark1
        case "poison":
            return MaterialColor.deepPurple.light1
        default:
            return MaterialColor.brown.light3
        }
    }
}
