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
    @IBOutlet weak var currentPageCountLabel1: UILabel!
    @IBOutlet weak var currentPageCountLabel2: UILabel!
    
    var currentPageCountLabel: UILabel!
    var nextPageCountLabel: UILabel {
        if currentPageCountLabel == currentPageCountLabel1 {
            return currentPageCountLabel2
        } else {
            return currentPageCountLabel1
        }
    }
    
    override var nibName: String {
        return "ConceptPageCount"
    }
    
    override func setup() {
        super.setup()
        
        view.backgroundColor = UIColor.clearColor()
        
        addShadowToLabel(totalPageCountLabel)
        addShadowToLabel(currentPageCountLabel1)
        addShadowToLabel(currentPageCountLabel2)
        
        currentPageCountLabel = currentPageCountLabel1
        currentPageCountLabel2.transform = CGAffineTransformMakeTranslation(0.0, -CGRectGetHeight(view.frame))
    }
    
    func addShadowToLabel(label: UILabel) {
        label.layer.shadowColor = UIColor.blackColor().CGColor
        label.layer.shadowOffset = CGSizeZero
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.3
        label.layer.masksToBounds = false
        label.layer.shouldRasterize = true
    }
    
    func updatePage(page: Int) {
        let labelToAnimateIn = nextPageCountLabel
        let labelToAnimateOut = currentPageCountLabel
        
        currentPageCountLabel = nextPageCountLabel
        
        labelToAnimateIn.text = "\(page + 1)"
        labelToAnimateIn.transform = CGAffineTransformMakeTranslation(0.0, -CGRectGetHeight(view.frame))
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
            labelToAnimateOut.transform = CGAffineTransformMakeTranslation(0.0, CGRectGetHeight(self.view.frame))
            labelToAnimateIn.transform = CGAffineTransformIdentity
            },  completion: nil)
    }
}
