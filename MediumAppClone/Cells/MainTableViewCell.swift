//
//  MainTableViewCell.swift
//  MediumAppClone
//
//  Created by Tutku Bide on 28.08.2020.
//  Copyright © 2020 Tutku Bide. All rights reserved.
//

import UIKit
import Parse

protocol MainTableViewCellProtocol {
    func tappedFav(tag: Int)
    func tappedTrashButton(tag: Int)
}

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var trashButton: UIButton!
    
    var delegate: MainTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let currentUser = PFUser.current()
        usernameLabel.text = currentUser?.username
        favButton.addTarget(self, action: #selector(tappedFav), for: .touchUpInside)
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOpacity = 0.5
        cellView.layer.shadowOffset = CGSize(width: 1, height: 2)
        cellView.layer.shadowRadius = 5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func tappedFav(sender: UIButton) {
        self.delegate?.tappedFav(tag: sender.tag)
        if favButton.isSelected == false {
            favButton.isSelected = true
        }else{
            favButton.isSelected = false
        }
    }
    
    @IBAction func trashTapped(_ sender: UIButton) {
        self.delegate?.tappedTrashButton(tag: sender.tag)
        let currentUser = PFUser.current()
        currentUser?.remove(forKey: "postOwnerTopic")
        currentUser?.saveInBackground(block: { (success, error) in
            if error != nil {
            }else{
                print("saved")
            }
        })
    }
}
