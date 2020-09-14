//
//  DynamicConstraint.swift
//  MediumAppClone
//
//  Created by Tutku Bide on 26.08.2020.
//  Copyright © 2020 Tutku Bide. All rights reserved.
//

import UIKit


final class DynamicConstraint: NSLayoutConstraint {
    
    @IBInspectable var ratio:CGFloat = 20
    @IBInspectable var isBasedOnWidth = true
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if isBasedOnWidth {
            constant = UIScreen.main.bounds.width/ratio
        } else {
            constant = UIScreen.main.bounds.height/ratio
        }
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
