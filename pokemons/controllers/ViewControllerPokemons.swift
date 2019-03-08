//
//  ViewControllerPokemons.swift
//  pokemons
//
//  Created by Alex on 06/03/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerPokemons: UIViewController {

    var pokemon: [Pokemon] = []
    var filteredPokemon: [Pokemon] = []
    var isSearching: Bool = false
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        pokemonSearchBar.delegate = self
        pokemonSearchBar.placeholder = "Buscar pokemon..."
        pokemonSearchBar.enablesReturnKeyAutomatically = false
        pokemon = Utils.getPokemons()
    }
    
}
extension ViewControllerPokemons: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredPokemon.count : pokemon.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "itemView") as! ViewControllerItem
        vc.pokemon = isSearching ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "myCell",for:indexPath) as! TableViewCellCustom
        let pokemon = isSearching ? self.filteredPokemon[indexPath.row] : self.pokemon[indexPath.row]
        if (pokemon.image != nil) {
            customCell.uiImage.image = pokemon.image!
        } else {
            customCell.uiImage.image = UIImage()
            Utils.getImage(url: pokemon.png, completion: {
                (image) -> Void in
                DispatchQueue.main.async {
                    customCell.uiImage.image = image
                    pokemon.image = image
                    return
                }
            })
        }
        customCell.caught.image = UIImage(named: pokemon.caught ? "tabbar_0_sel" : "tabbar_0")
        customCell.selectionStyle = .none
        customCell.uiImage.contentMode = .scaleAspectFit
        customCell.uiName.text = pokemon.name
        customCell.setTypes(type1: pokemon.type, type2: pokemon.type2)
        return customCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.3,0.3,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [toggleCatch(indexPath: indexPath)])
    }
    
    func toggleCatch(indexPath:IndexPath) -> UIContextualAction{
        let pokemon = isSearching ? filteredPokemon[indexPath.row] : self.pokemon[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
            pokemon.caught = !pokemon.caught
            Utils.toggleCaught(pokemon)
            self.pokemonTableView.reloadRows(at: [indexPath], with: .none)
            action.title = "You caught it!"
            completion(true)
        }
        action.title = pokemon.caught ? "Free it!" : "Catch"
        action.image = UIImage(named: "tabbar_0_sel")
        action.backgroundColor =  pokemon.caught ? .red : .green
        return action
    }
}
extension ViewControllerPokemons: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPokemon = pokemon.filter({ (pokemon) -> Bool in
            return pokemon.name.lowercased().contains(searchText.lowercased())
        })
        isSearching = searchText != ""
        pokemonTableView.reloadData()
        pokemonTableView.setContentOffset(.zero, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
