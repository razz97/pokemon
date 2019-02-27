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
    var imagen: UIImage = UIImage()
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descrLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name
        image.image = imagen
        descrLbl.text = pokemon.description
    }
}
