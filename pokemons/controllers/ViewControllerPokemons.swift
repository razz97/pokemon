//
//  ViewControllerPokemons.swift
//  pokemons
//
//  Created by Alex on 06/03/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerPokemons : UIViewController {

    var pokemon: [Pokemon] = []
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        pokemon = Utils.getPokemons()
    }
    
}
extension ViewControllerPokemons: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "itemView") as! ViewControllerItem
        vc.pokemon = pokemon[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "myCell",for:indexPath) as! TableViewCellCustom
        let pokemon = self.pokemon[indexPath.row]
        if (pokemon.image != nil) {
            customCell.uiImage.image = pokemon.image!
        } else {
            customCell.uiImage.image = UIImage()
            Utils.getImage(url: pokemon.png, completion: {
                (image) -> Void in
                DispatchQueue.main.async {
                    print("downloaded")
                    customCell.uiImage.image = image
                    pokemon.image = image
                    return
                }
            })
        }
        customCell.uiImage.contentMode = .scaleAspectFit
        customCell.uiName.text = pokemon.name
        return customCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
