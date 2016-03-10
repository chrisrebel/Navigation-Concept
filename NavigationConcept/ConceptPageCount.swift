//
//  ConceptPageCount.swift
//  NavigationConcept
//
//  Created by crebel on 3/9/16.
//  Copyright © 2016 Rentpath. All rights reserved.
//

import UIKit
import QuartzCore

class ConceptPageCount: BaseCustomView {

    @IBOutlet weak var totalPageCountLabel: UILabel!
    
    override var nibName: String {
        return "ConceptPageCount"
    }
    
    override func setup() {
        super.setup()
        
        view.backgroundColor = UIColor.clearColor()
        
        totalPageCountLabel.layer.shadowColor = UIColor.blackColor().CGColor
        totalPageCountLabel.layer.shadowOffset = CGSizeZero
        totalPageCountLabel.layer.shadowRadius = 2.0
        totalPageCountLabel.layer.shadowOpacity = 0.3
        totalPageCountLabel.layer.masksToBounds = false
        totalPageCountLabel.layer.shouldRasterize = true
    }

}
