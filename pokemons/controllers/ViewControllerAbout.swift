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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutMe.layer.cornerRadius = aboutMe.frame.size.height/2
        aboutMe.clipsToBounds = true
        aboutApp.layer.cornerRadius = aboutApp.frame.size.height/2
        aboutApp.clipsToBounds = true
        self.view.backgroundColor = UIColor(red: 237/255, green: 116/255, blue: 150/255, alpha: 1)
        // Do any additional setup after loading the view.
    }

}
