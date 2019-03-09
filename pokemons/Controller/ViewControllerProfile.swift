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
    @IBOutlet weak var usernam: UITextField!
    @IBOutlet weak var catches: UILabel!
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageProperties()
        bindControls()
        imagePicker.navigationBar.tintColor = .black
    }
    
    func bindControls() {
        collectionView.delegate = self
        collectionView.dataSource = self
        usernam.delegate = self
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        catches.text = "\(Dao.instance.caught.count)"
        usernam.text = Dao.instance.username
        profImage.image = Dao.instance.image
        collectionView.reloadData()
    }
    
    func setImageProperties() {
        profImage.frame.size = CGSize(width: view.frame.height * 0.125, height: view.frame.height * 0.125)
        profImage.layer.cornerRadius = profImage.frame.size.height/2
        profImage.clipsToBounds = true
        profImage.contentMode = .scaleAspectFill
        let tapProfileImageRec = UITapGestureRecognizer()
        tapProfileImageRec.addTarget(self, action: #selector(imageTapped))
        profImage.addGestureRecognizer(tapProfileImageRec)
    }
}
extension ViewControllerProfile: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Dao.instance.caught.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CollectionViewCellCustom
        let pokemon = Dao.instance.caught[indexPath.row]
        if pokemon.image != nil {
            cell.img.image = pokemon.image!
        } else {
            cell.img.image = UIImage()
            Dao.instance.getImage(url: pokemon.png, completion: {
                (image) -> Void in
                DispatchQueue.main.async {
                    cell.img.image = image
                    pokemon.image = image
                    return
                }
            })
        }
        cell.backgroundColor = Pokemon.colors[pokemon.type]
        cell.pokemonName.text = pokemon.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "itemView") as! ViewControllerItem
        vc.pokemon = Dao.instance.caught[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewControllerProfile: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" && textField.text != Dao.instance.username {
            Dao.instance.username = usernam.text!
        }
    }
}
extension ViewControllerProfile: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image: UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profImage.image = image
        Dao.instance.image = image
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imageTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePicker.sourceType = sourceType
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}
