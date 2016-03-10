//
//  ConceptDetailViewController.swift
//  NavigationConcept
//
//  Created by crebel on 3/8/16.
//  Copyright © 2016 Rentpath. All rights reserved.
//

import UIKit

class ConceptDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!

    var isInitialLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapAction"))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        if isInitialLoad {
            isInitialLoad = false
            
            view.setNeedsLayout()
            view.layoutIfNeeded()
            
            super.viewDidLayoutSubviews()
        }
    }
    
    func tapAction() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
