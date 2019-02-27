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
    
    static func parseCSVPokemon() -> [Pokemon] {
        
        //Obtengo el fichero y su tipo
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        var pokemons: [Pokemon] = []
        do{
            
            //Utilizo la librería para obtener la decodificación
            let csv = try CSV(contentsOfURL: path)
            
            //Recorro el fichero por filas y lo guardo en el array
            for row in csv.rows {
                pokemons.append(Pokemon(number: Int(row["Number"]!)!, name: row["Pokemon"]!, type: row["Type 1"]!, hp: Int(row["HP"]!)!, attack: Int(row["Attack"]!)!, defense: Int(row["Defense"]!)!, speed: Int(row["Speed"]!)!, special: Int(row["Special"]!)!, gif: row["GIF"]!, png: row["PNG"]!, description: row["Description"]!))
            }
            
        } catch let error as NSError {
            print("Error decodificando el CSV", error)
        }
        return pokemons
    }
    
    static func getImage(imagenURL:String, completion: @escaping (_ image: UIImage?) -> ()) {
        
        let imgURL = URL(string: imagenURL)!
        //var imagen:UIImage = UIImage()
        
        //Creates a default configuration object that uses the disk-persisted global cache, credential and cookie storage objects.
        //Creamos la sesion
        let session = URLSession(configuration: .default)
        
        //Obtengo la URL definiendola del tipo data, el cod de respuesta y el error
        session.dataTask(with: imgURL) { (data, response, error) in
            //Una vez descargada la imagen puedo tratarla
            //Comprobamos que no se haya producido ningun error
            if let e = error {
                print("Error downloading image: \(e)")
            } else {
                // Tratamos la respuesta de la URL
                //Comprobamos el tipo de respuesta obtenida
                if let res = response as? HTTPURLResponse {
                    print("Downloaded image with response code \(res.statusCode)") //200 todo OK
                    //Tratamos el data obtenido de la URL
                    if let imageData = data {
                        // Convertimos la imagen del tipo data a una UIImage para poder enviarla en el completion
                        completion(UIImage(data: imageData)!)
                    } else {
                        print("Couldn't get image: Image is nil") //No se ha podido obtener el recurso
                    }
                } else {
                    print("Couldn't get response code for some reason") //El servidor no esta accesible
                }
            }
            }.resume()
    }
    
}
