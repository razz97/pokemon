//
//  ViewControllerProfile.swift
//  pokemons
//
//  Created by Alex on 08/03/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import UIKit

class ViewControllerProfile: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var profImage: UIImageView!
    
    @IBOutlet weak var catches: UILabel!
    
    var caught: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        profImage.layer.cornerRadius = profImage.frame.size.height/2
        profImage.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        caught = Utils.getCaught()
        catches.text = String(caught.count)
        collectionView.reloadData()
    }
    
}
extension ViewControllerProfile: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return caught.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CollectionViewCellCustom
        let pokemon = caught[indexPath.row]
        if pokemon.image != nil {
            cell.img.image = caught[indexPath.row].image!
        } else {
            cell.img.image = UIImage()
            Utils.getImage(url: pokemon.png, completion: {
                (image) -> Void in
                DispatchQueue.main.async {
                    cell.img.image = image
                    pokemon.image = image
                    return
                }
            })
        }
        cell.layer.borderColor = Utils.getColor(forType: pokemon.type).cgColor
        cell.pokemonName.text = pokemon.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "itemView") as! ViewControllerItem
        vc.pokemon = caught[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
