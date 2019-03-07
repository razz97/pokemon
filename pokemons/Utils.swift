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
                pokemons!.append(Pokemon(number: Int(row["Number"]!)!, name: row["Pokemon"]!, type: row["Type 1"]!, hp: Int(row["HP"]!)!, attack: Int(row["Attack"]!)!, defense: Int(row["Defense"]!)!, speed: Int(row["Speed"]!)!, special: Int(row["Special"]!)!, gif: row["GIF"]!, png: row["PNG"]!, description: row["Description"]!))
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
}
