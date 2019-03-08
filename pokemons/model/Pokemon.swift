//
//  Pokemon.swift
//  pokemons
//
//  Created by Alex Bou on 30/01/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import Foundation
import UIKit

class Pokemon: Codable, Equatable {
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.number == rhs.number
    }
    
    
    let number: Int
    let name: String
    let type: String
    let type2: String
    let hp: Int
    let attack: Int
    let defense: Int
    let speed: Int
    let special: Int
    let gif: String
    let png: String
    let description: String
    var image: UIImage?
    var gifImage: UIImage?
    var caught: Bool
    
    private enum CodingKeys: String,CodingKey {
        case number, name, type, type2, hp, attack, defense, speed, special, gif, png, description, caught
    }
    
    init(number: Int, name: String, type: String, type2: String, hp: Int, attack: Int, defense: Int, speed: Int, special: Int, gif: String, png: String, description: String, caught: Bool = false) {
        self.number = number
        self.name = name
        self.type = type
        self.type2 = type2
        self.hp = hp
        self.attack = attack
        self.defense = defense
        self.speed = speed
        self.special = special
        self.gif = gif
        self.png = png
        self.description = description
        self.caught = caught
    }
    
    static let colors: [String: UIColor] = [
         "Grass": UIColor(red: 100/255, green: 177/255, blue: 61/255, alpha: 1),
         "Fire": UIColor(red: 223/255, green: 107/255, blue: 24/255, alpha: 1),
         "Water": UIColor(red: 75/255, green: 123/255, blue: 234/255, alpha: 1),
         "Poison": UIColor(red: 143/255, green: 62/255, blue: 144/255, alpha: 1),
         "Flying": UIColor(red: 164/255, green: 139/255, blue: 232/255, alpha: 1),
         "Bug": UIColor(red: 156/255, green: 168/255, blue: 32/255, alpha: 1),
         "Normal": UIColor(red: 151/255, green: 148/255, blue: 105/255, alpha: 1),
         "Electric": UIColor(red: 244/255, green: 196/255, blue: 10/255, alpha: 1),
         "Ground": UIColor(red: 216/255, green: 177/255, blue: 71/255, alpha: 1),
         "Fighting": UIColor(red: 160/255, green: 45/255, blue: 36/255, alpha: 1),
         "Psychic": UIColor(red: 238/255, green: 39/255, blue: 95/255, alpha: 1),
         "Rock": UIColor(red: 164/255, green: 143/255, blue: 52/255, alpha: 1),
         "Ice": UIColor(red: 123/255, green: 203/255, blue: 204/255, alpha: 1),
         "Ghost": UIColor(red: 97/255, green: 73/255, blue: 131/255, alpha: 1),
         "Dragon": UIColor(red: 88/255, green: 24/255, blue: 242/255, alpha: 1)
    ]
    
    
    
    
}
