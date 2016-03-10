//
//  UIImage.swift
//  NavigationConcept
//
//  Created by crebel on 3/10/16.
//  Copyright © 2016 Rentpath. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(CGImage: image.CGImage!)
    }
}
