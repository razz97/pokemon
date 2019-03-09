//
//  Utils.swift
//  pokemons
//
//  Created by Alex Bou on 01/02/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import Foundation
import UIKit

class Dao {
        
    static let instance: Dao = Dao()
    
    private(set) var pokemons: [Pokemon] = []
    private(set) var caught: [Pokemon] = []
    private var _username: String = ""
    private var _image: UIImage = UIImage()
    
    var username: String {
        get { return _username }
        set {
            _username = newValue
            UserDefaults.standard.set(newValue, forKey: "username")
        }
    }
    
    var image: UIImage {
        get { return _image }
        set {
            _image = newValue
            UserDefaults.standard.set(newValue.jpegData(compressionQuality: 0.5), forKey: "image")
        }
    }
    
    private init() {
        readCaught()
        readPokemons()
        readUser()
    }
    
    private func readCaught() {
        if let storedObject: Data = UserDefaults.standard.data(forKey: "caught") {
            do {
                caught = try PropertyListDecoder().decode([Pokemon].self, from: storedObject)
            } catch {
                caught = []
            }
        } else {
            caught = []
        }
    }
    
    private func writeCaught() {
        do {
            UserDefaults.standard.set(try PropertyListEncoder().encode(caught), forKey: "caught")
            UserDefaults.standard.synchronize()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func readPokemons() {
        print("reading pokemons")
        do {
            let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
            let csv = try CSV(contentsOfURL: path)
            for row in csv.rows {
                let tmpPokemon = Pokemon(number: Int(row["Number"]!)!, name: row["Pokemon"]!, type: row["Type 1"]!, type2: row["Type 2"]!, hp: Int(row["HP"]!)!, attack: Int(row["Attack"]!)!, defense: Int(row["Defense"]!)!, speed: Int(row["Speed"]!)!, special: Int(row["Special"]!)!, gif: row["GIF"]!, png: row["PNG"]!, description: row["Description"]!)
                pokemons.append(tmpPokemon)
                tmpPokemon.caught = caught.contains(tmpPokemon)
            }
        } catch {
            print("Error decodificando el CSV")
        }
    }
    
    private func readUser() {
        username = UserDefaults.standard.string(forKey: "username") ?? "User"
        let imgData = UserDefaults.standard.data(forKey: "image")
        if (imgData != nil) {
            image = UIImage(data: imgData!) ?? UIImage(named: "usr")!
        } else {
            image = UIImage(named: "usr")!
        }
    }
    
    func getImage(url:String, completion: @escaping (_ image: UIImage?) -> ()) {
        URLSession(configuration: .default).dataTask(
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
    
    func getGif(url:String, completion: @escaping (_ image: UIImage?) -> ()) {
        UIImage.gifImageWithURL(url: url, completion: completion)
    }
    
    func toggleCaught(_ pokemon:Pokemon) {
        let index: Int? = caught.firstIndex(of: pokemon)
        if index == nil {
            caught.append(pokemon)
        } else {
            caught.remove(at: index!)
        }
        writeCaught()
    }
    
    func setUsername(_ user: String) {
        username = user
        UserDefaults.standard.set(user, forKey: "username")
    }
    
    func setImage(_ image: UIImage){
        self.image = image
        UserDefaults.standard.set(image.jpegData(compressionQuality: 0.5), forKey: "image")
    }
    
}
