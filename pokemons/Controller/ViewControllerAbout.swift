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
    @IBOutlet weak var linkedin: UIImageView!
    @IBOutlet weak var github: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
        setupLinks()
    }
    
    func setupImage() {
        aboutMe.frame.size = CGSize(width: view.frame.height * 0.1, height: view.frame.height * 0.1)
        aboutMe.layer.cornerRadius = aboutMe.frame.size.height/2
        aboutMe.clipsToBounds = true
    }
    
    func setupLinks() {
        let tapLiknedinRec = UITapGestureRecognizer()
        tapLiknedinRec.addTarget(self, action: #selector(onTapLinkedin))
        linkedin.addGestureRecognizer(tapLiknedinRec)
        let tapGithubRec = UITapGestureRecognizer()
        tapGithubRec.addTarget(self, action: #selector(onTapGithub))
        github.addGestureRecognizer(tapGithubRec)
    }
    
    @objc func onTapLinkedin() {
        guard let url = URL(string: "https://www.linkedin.com/in/abou") else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func onTapGithub() {
        guard let url = URL(string: "https://github.com/razz97") else { return }
        UIApplication.shared.open(url)
    }
}
