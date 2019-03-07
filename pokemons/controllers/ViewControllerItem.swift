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
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descrLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name
        if pokemon.image != nil {
            image.image = pokemon.image!
        } else {
            Utils.getImage(url: pokemon.png, completion: {
                (image) -> Void in
                DispatchQueue.main.async {
                    self.image.image = image
                    self.pokemon.image = image
                    return
                }
            })
        }
        descrLbl.text = pokemon.description
    }
}
