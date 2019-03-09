//
//  CollectionViewCellCustom.swift
//  pokemons
//
//  Created by Alex on 08/03/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import UIKit

class CollectionViewCellCustom: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }   
}
