//
//  MainViewController.swift
//  MediumAppClone
//
//  Created by Tutku Bide on 28.08.2020.
//  Copyright © 2020 Tutku Bide. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var data = [Model]()
    var isMain = false
    var isFav = false
    var myTpicData = [myTopicModel]()
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorStyle = .none
        fetchData()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: NSNotification.Name("newPost"), object: nil)
    }
    
    @objc func fetchData() {
        if let ownerTopic = PFUser.current()!["postOwnerTopic"] as? String {
            myTpicData.append(myTopicModel(topic: ownerTopic))
        }
        let fetchData = PFQuery(className: "Posts")
        fetchData.addDescendingOrder("createdAt")
        fetchData.findObjectsInBackground { (objects, error) in
            if error != nil {
                print("error")
            }else{
                self.data.removeAll(keepingCapacity: true)
                if objects != nil {
                    for object in objects! {
                        
                        if let topic = object.object(forKey: "topics") as? String {
                            if let texts = object.object(forKey: "texts") as? String {
                                if let username = object.object(forKey: "postOwner") as? String {
                                    
                                    self.data.append(Model(topic: topic, str: texts, isFav: false, userName: username, objectId: object.objectId ?? ""))
                                }
                            }
                            
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isMain == false {
            return data.count
        }
        return myTpicData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        if isMain == false {
            let item = data[indexPath.row]
            cell.topicLabel.text = item.topic
            cell.selectionStyle = .none
            cell.favButton.tag = indexPath.row
            cell.delegate = self
            cell.favButton.isSelected = item.isFav
            cell.usernameLabel.text = item.userName
            cell.trashButton.isHidden = true
        } else {
            let item = myTpicData[indexPath.row]
            cell.topicLabel.text = item.topic
            cell.favButton.isHidden = true
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = board.instantiateViewController(withIdentifier: "detailVC") as! DetailsViewController
        tabBar.topicString = data[indexPath.item].topic
        tabBar.textString = data[indexPath.item].str
        navigationController?.pushViewController(tabBar, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MainViewController: MainTableViewCellProtocol {
    func tappedFav(tag: Int) {
        print(tag)
        data[tag].isFav = !data[tag].isFav
        favFunc(with: data[tag].objectId, bool: data[tag].isFav)
        self.listTableView.reloadData()
    }
    
    func favFunc(with id: String, bool: Bool) {
        let query = PFQuery(className: "Posts")
        query.getObjectInBackground(withId: id) { (object, error) in
            if object != nil && error == nil {
                if bool {
                    object!["FavoriListesi"] = "Add Fav"
                    object!.saveInBackground()
                }else{
                    object!["FavoriListesi"] = "Del Fav"
                    object!.saveInBackground()
                }
            }
        }
    }
    
    func tappedTrashButton(tag: Int) {
        myTpicData.remove(at: tag)
        listTableView.reloadData()
    }
}
