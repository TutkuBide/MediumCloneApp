//
//  ViewController.swift
//  MediumAppClone
//
//  Created by Tutku Bide on 21.08.2020.
//  Copyright © 2020 Tutku Bide. All rights reserved.
//

import UIKit
import Parse


class ProfilViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var profilImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var editProfilImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = PFUser.current()
        mailLabel.text = currentUser?.email
        nameLabel.text = currentUser?.username
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        view.addGestureRecognizer(recognizer)
        let useravatar = currentUser!["avatar"] as? PFFileObject
        useravatar?.getDataInBackground{ (imageData, error)in
            if imageData != nil {
                let image = UIImage(data: imageData!)
                self.profilImageView.image = image
                self.editProfilImageView.isHidden = false
            }
        }
    }
    
    func updateCurrentUserProfilePicture(image: UIImage) {
        let avatar = PFFileObject(name: PFUser.current()!.username, data: image.pngData()!)
        PFUser.current()!.setObject(avatar!, forKey: "avatar")
        PFUser.current()!.saveInBackground { (success, error) in
            if error != nil {
                print("error")
            }else{
                print("upload image")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profilImageView.image = info[.originalImage] as? UIImage
        updateCurrentUserProfilePicture(image: profilImageView.image!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                print("error")
            }else{
                self.performSegue(withIdentifier: "loginVC", sender: nil)
            }
        }
    }
    
    @IBAction func myDocumentTapped(_ sender: Any) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = board.instantiateViewController(withIdentifier: "mainVC") as! MainViewController
        tabBar.isMain = true
        navigationController?.pushViewController(tabBar, animated: true)
    }
    
    @IBAction func myAccountTapped(_ sender: Any) {
        
    }
    
    @IBAction func favButton(_ sender: Any) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = board.instantiateViewController(withIdentifier: "favoriteVC") as! FavoriteViewController
        navigationController?.pushViewController(tabBar, animated: true)
    }
}
