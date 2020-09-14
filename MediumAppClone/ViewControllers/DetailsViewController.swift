//
//  DetailsViewController.swift
//  MediumAppClone
//
//  Created by Tutku Bide on 29.08.2020.
//  Copyright © 2020 Tutku Bide. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var stringTextView: UITextView!
    
    var topicString = ""
    var textString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topicLabel.text = topicString
        stringTextView.text = textString
        topicLabel.adjustsFontSizeToFitWidth = true
        stringTextView.isUserInteractionEnabled = true
        if stringTextView.text == "Yazmak İçin Dokun" {
            stringTextView.text = ""
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
