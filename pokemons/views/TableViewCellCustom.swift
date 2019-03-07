//
//  TableViewCellCustom.swift
//  TableViewClick
//
//  Created by Alex Bou on 18/01/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import UIKit

class TableViewCellCustom: UITableViewCell {

    @IBOutlet weak var uiType: UIImageView!
    
    @IBOutlet weak var uiName: UILabel!
    
    @IBOutlet weak var uiImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
