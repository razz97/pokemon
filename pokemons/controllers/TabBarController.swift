//
//  TabBarController.swift
//  pokemons
//
//  Created by Alex on 07/03/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let margin = tabBar.frame.height * 0.3
        for (index,item) in self.tabBar.items!.enumerated() {
            item.image = UIImage(named: "tabbar_\(index)")!.withRenderingMode(.alwaysOriginal)
            item.selectedImage = UIImage(named: "tabbar_\(index)_sel")!.withRenderingMode(.alwaysOriginal)
            item.imageInsets = UIEdgeInsets(top: margin, left: 0, bottom: -margin, right: 0)
        }
    }

}
