//
//  FavoriteTableViewCell.swift
//  MediumAppClone
//
//  Created by Tutku Bide on 3.09.2020.
//  Copyright © 2020 Tutku Bide. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var topicTxt: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOpacity = 0.5
        cellView.layer.shadowOffset = CGSize(width: 1, height: 2)
        cellView.layer.shadowRadius = 5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
