//
//  BaseCustomView.swift
//  NavigationConcept
//
//  Created by crebel on 3/9/16.
//  Copyright © 2016 Rentpath. All rights reserved.
//

import UIKit

import UIKit

class BaseCustomView: UIView {
    
    var nibName: String {
        assert(false, "This method must be overriden by the subclass")
        return ""
    }
    
    var view: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        view = loadViewFromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        let views = ["view": view]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: [], metrics: nil, views: views))
    }
    
    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName: nibName, bundle: nil)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
}

