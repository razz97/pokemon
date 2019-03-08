//
//  TableViewCellCustom.swift
//  TableViewClick
//
//  Created by Alex Bou on 18/01/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import UIKit

class TableViewCellCustom: UITableViewCell {

    @IBOutlet weak var uiType1: UIButton!
    
    @IBOutlet weak var uiType2: UIButton!
    
    @IBOutlet weak var uiName: UILabel!
    
    @IBOutlet weak var uiImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setTypes(type1: String, type2: String) {
        uiType1.setTitle(type1.uppercased(), for: .normal)
        uiType1.backgroundColor = Pokemon.colors[type1]
        uiType1.layer.cornerRadius = 10
        uiType1.clipsToBounds = true
        uiType2.setTitle(type2.uppercased(), for: .normal)
        uiType2.backgroundColor = Pokemon.colors[type2]
        uiType2.layer.cornerRadius = 10
        uiType2.clipsToBounds = true

    }
    

    

}
