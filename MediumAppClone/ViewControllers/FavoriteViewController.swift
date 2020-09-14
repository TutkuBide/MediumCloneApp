//
//  FavoriteViewController.swift
//  MediumAppClone
//
//  Created by Tutku Bide on 3.09.2020.
//  Copyright © 2020 Tutku Bide. All rights reserved.
//

import UIKit
import Parse

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var favListTableView: UITableView!
    private var data = [favoriteModel]()
    private var favoritedModel = [favoriteModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        self.favListTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    
    func fetchData() {
        let fetchData = PFQuery(className: "Posts")
        fetchData.addDescendingOrder("createdAt")
        fetchData.findObjectsInBackground { (objects, error) in
            if error != nil {
                print("error")
            }else{
                if objects != nil {
                    for object in objects! {
                        if let topic = object.object(forKey: "topics") as? String {
                            if let favorite = object.object(forKey: "FavoriListesi") as? String {
                                self.data.append(favoriteModel(topic: topic, isFav: favorite))
                            }
                        }
                    }
                    
                    for i in self.data {
                        if i.isFav == "Add Fav" {
                            self.favoritedModel.append(i)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.favListTableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritedModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        cell.topicTxt.text = favoritedModel[indexPath.item].topic
        cell.selectionStyle = .none
        cell.trashButton.isHidden = true
        cell.favButton.isSelected = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
