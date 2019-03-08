//
//  ViewControllerAbout.swift
//  pokemons
//
//  Created by Alex on 07/03/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import UIKit

class ViewControllerAbout: UIViewController {
    
    @IBOutlet weak var aboutMe: UIImageView!
    
    @IBOutlet weak var aboutApp: UIImageView!
    
    @IBOutlet weak var txtAbout: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutMe.layer.cornerRadius = aboutMe.frame.size.height/2
        aboutMe.clipsToBounds = true
        aboutApp.layer.cornerRadius = aboutApp.frame.size.height/2
        aboutApp.clipsToBounds = true        
    }

}
