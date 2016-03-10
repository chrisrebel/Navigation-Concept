//
//  UIView.swift
//  NavigationConcept
//
//  Created by crebel on 3/8/16.
//  Copyright © 2016 Rentpath. All rights reserved.
//

import UIKit

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
}
