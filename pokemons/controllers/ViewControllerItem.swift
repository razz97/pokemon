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
    @IBOutlet weak var uiType1: UIButton!
    @IBOutlet weak var uiType2: UIButton!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var hp: UILabel!
    @IBOutlet weak var atk: UILabel!
    @IBOutlet weak var def: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var spAtk: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGif()
        setInfo()
        setTypes()
    }
    
    func setGif() {
        if (pokemon.gifImage != nil) {
            image.image = pokemon.gifImage
        } else {
            UIImage.gifImageWithURL(url:pokemon.gif, completion: {
                (img) -> Void in
                DispatchQueue.main.async {
                    self.pokemon.gifImage = img
                    self.image.image = img
                    return
                }
            })
        }
    }
    
    func setInfo() {
        descrLbl.text = pokemon.description
        navItem.title = pokemon.name
        number.text = String(pokemon.number)
        hp.text = String(pokemon.hp)
        atk.text = String(pokemon.attack)
        def.text = String(pokemon.defense)
        speed.text = String(pokemon.speed)
        spAtk.text = String(pokemon.special)
    }
    
    func setTypes() {
        uiType1.setTitle(pokemon.type.uppercased(), for: .normal)
        uiType1.backgroundColor = Pokemon.colors[pokemon.type]
        uiType1.layer.cornerRadius = 10
        uiType1.clipsToBounds = true
        uiType2.setTitle(pokemon.type2.uppercased(), for: .normal)
        uiType2.backgroundColor = Pokemon.colors[pokemon.type2]
        uiType2.layer.cornerRadius = 10
        uiType2.clipsToBounds = true
    }
}
