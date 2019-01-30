//
//  Pokemon.swift
//  pokemons
//
//  Created by Alex Bou on 30/01/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import Foundation
import UIKit

class Pokemon {
    
    let number: Int
    let name: String
    let type: String
    let hp: Int
    let attack: Int
    let defense: Int
    let speed: Int
    let special: Int
    let gif: String
    let png: String
    let description: String
    
    init(number: Int, name: String, type: String, hp: Int, attack: Int, defense: Int, speed: Int, special: Int, gif: String, png: String, description: String) {
        self.number = number
        self.name = name
        self.type = type
        self.hp = hp
        self.attack = attack
        self.defense = defense
        self.speed = speed
        self.special = special
        self.gif = gif
        self.png = png
        self.description = description

    }
    
    
    
    
}
