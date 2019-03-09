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
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonTableView: UITableView!
    
    var filteredPokemon: [Pokemon] = []
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        pokemonSearchBar.delegate = self
        pokemonSearchBar.placeholder = "Buscar pokemon..."
        pokemonSearchBar.enablesReturnKeyAutomatically = false
    }
    
}
extension ViewControllerPokemons: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredPokemon.count : Dao.instance.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "itemView") as! ViewControllerItem
        vc.pokemon = isSearching ? filteredPokemon[indexPath.row] : Dao.instance.pokemons[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "myCell",for:indexPath) as! TableViewCellCustom
        let pokemon = isSearching ? filteredPokemon[indexPath.row] : Dao.instance.pokemons[indexPath.row]
        if (pokemon.image != nil) {
            customCell.uiImage.image = pokemon.image!
        } else {
            customCell.uiImage.image = UIImage()
            Dao.instance.getImage(url: pokemon.png, completion: { (image) -> Void in
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
        let pokemon = isSearching ? filteredPokemon[indexPath.row] : Dao.instance.pokemons[indexPath.row]
        let action = UIContextualAction(style: .normal, title: pokemon.caught ? "Free it!" : "Catch it!",
            handler: {(action, view, completion) in
                pokemon.caught = !pokemon.caught
                Dao.instance.toggleCaught(pokemon)
                UIView.performWithoutAnimation {
                    self.pokemonTableView.reloadRows(at: [indexPath], with: .none)
                }
                completion(true)
            }
        )
        if pokemon.caught {
            action.image = UIImage(named: "uncatch")!
            action.backgroundColor = UIColor(red: 202/255, green: 52/255, blue: 51/255, alpha: 1)
        } else {
            action.image = UIImage(named: "catch")!
            action.backgroundColor = UIColor(red: 80/255, green: 220/255, blue: 100/255, alpha: 1)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
extension ViewControllerPokemons: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPokemon = Dao.instance.pokemons.filter({ (pokemon) -> Bool in
            return pokemon.name.lowercased().contains(searchText.lowercased())
        })
        filteredPokemon.append(contentsOf: Dao.instance.pokemons.filter({ (pokemon) -> Bool in
            return pokemon.type.lowercased().contains(searchText.lowercased())
                || pokemon.type2.lowercased().contains(searchText.lowercased())
        }))
        isSearching = searchText != ""
        pokemonTableView.reloadData()
        if filteredPokemon.count > 0  && isSearching {
            pokemonTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
