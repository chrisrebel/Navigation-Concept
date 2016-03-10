//
//  UILabel.swift
//  NavigationConcept
//
//  Created by crebel on 3/9/16.
//  Copyright © 2016 Rentpath. All rights reserved.
//

import UIKit

extension UILabel {
    
    func toImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0)
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
}
