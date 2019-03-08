//
//  ViewControllerItem.swift
//  TableViewClick
//
//  Created by Alex Bou on 23/01/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import UIKit

class ViewControllerItem: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descrLbl: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.image = .gifImageWithURL(pokemon.gif)
        descrLbl.text = pokemon.description
        navItem.title = pokemon.name
    }
}
