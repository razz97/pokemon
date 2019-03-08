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
    
    @IBOutlet weak var catches: UILabel!
    
    var caught: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        caught = Utils.getPokemons()
        catches.text = String(caught.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        return cell
    }
    
    
}
