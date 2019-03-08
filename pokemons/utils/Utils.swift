//
//  Utils.swift
//  pokemons
//
//  Created by Alex Bou on 01/02/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    private static var pokemons: [Pokemon]?
    private static let session: URLSession = URLSession(configuration: .default)
    
    static func getPokemons() -> [Pokemon] {
        if pokemons != nil {
            return pokemons!
        }
        do {
            pokemons = []
            let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
            let csv = try CSV(contentsOfURL: path)
            for row in csv.rows {
                pokemons!.append(Pokemon(number: Int(row["Number"]!)!, name: row["Pokemon"]!, type: row["Type 1"]!, type2: row["Type 2"]!, hp: Int(row["HP"]!)!, attack: Int(row["Attack"]!)!, defense: Int(row["Defense"]!)!, speed: Int(row["Speed"]!)!, special: Int(row["Special"]!)!, gif: row["GIF"]!, png: row["PNG"]!, description: row["Description"]!))
            }
        } catch let error as NSError {
            print("Error decodificando el CSV", error)
        }
        return pokemons!
    }
    
    static func getImage(url:String, completion: @escaping (_ image: UIImage?) -> ()) {
        session.dataTask(
            with: URL(string: url)!,
            completionHandler: { (data, response, error) in
                if error != nil {
                    print("Error downloading image: \(error!)")
                } else if  response != nil && data != nil {
                    completion(UIImage(data: data!)!)
                } else {
                    print("Unexpected error fetching image")
                }
            }
        ).resume()
    }
    
    static func getColor(forType: String) -> UIColor {
        switch (forType) { //rgb(88, 24, 242)
        case "Grass": return UIColor(red: 100/255, green: 177/255, blue: 61/255, alpha: 1)
        case "Fire": return UIColor(red: 223/255, green: 107/255, blue: 24/255, alpha: 1)
        case "Water": return UIColor(red: 75/255, green: 123/255, blue: 234/255, alpha: 1)
        case "Poison": return UIColor(red: 143/255, green: 62/255, blue: 144/255, alpha: 1)
        case "Flying": return UIColor(red: 164/255, green: 139/255, blue: 232/255, alpha: 1)
        case "Bug": return UIColor(red: 156/255, green: 168/255, blue: 32/255, alpha: 1)
        case "Normal": return UIColor(red: 151/255, green: 148/255, blue: 105/255, alpha: 1)
        case "Electric": return UIColor(red: 244/255, green: 196/255, blue: 10/255, alpha: 1)
        case "Ground": return UIColor(red: 216/255, green: 177/255, blue: 71/255, alpha: 1)
        case "Fighting": return UIColor(red: 160/255, green: 45/255, blue: 36/255, alpha: 1)
        case "Psychic": return UIColor(red: 238/255, green: 39/255, blue: 95/255, alpha: 1)
        case "Rock": return UIColor(red: 164/255, green: 143/255, blue: 52/255, alpha: 1)
        case "Ice": return UIColor(red: 123/255, green: 203/255, blue: 204/255, alpha: 1)
        case "Ghost": return UIColor(red: 97/255, green: 73/255, blue: 131/255, alpha: 1)
        case "Dragon": return UIColor(red: 88/255, green: 24/255, blue: 242/255, alpha: 1)
        default: return .white
        }
    }
    
    static func getCaught() -> [Pokemon] {
        return getPokemons()
    }
}
