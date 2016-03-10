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
    @IBOutlet weak var addressLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var bedsLabel: UILabel!
    @IBOutlet weak var bathsLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var closeImageView: UIImageView!

    @IBOutlet weak var favoriteTapView: UIView!
    @IBOutlet weak var closeTapView: UIView!
    
    @IBOutlet weak var review1: UIView!
    @IBOutlet weak var review1ProfileImage: UIImageView!
    @IBOutlet weak var review2: UIView!
    @IBOutlet weak var review2ProfileImage: UIImageView!
    @IBOutlet weak var review3: UIView!
    @IBOutlet weak var review3ProfileImage: UIImageView!
    
    var isInitialLoad = true
    
    var isFavorited = false
    
    var listing: Listing!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        review1ProfileImage.hidden = true
        review2ProfileImage.hidden = true
        review3ProfileImage.hidden = true
        
        closeTapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapAction"))
        
        favoriteTapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "favoriteAction"))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        if isInitialLoad {
            isInitialLoad = false
            
            bedsLabel.text = listing.beds
            bathsLabel.text = listing.baths
            addressLabel.text = listing.address
            photoView.image = UIImage(named: listing.image)
            
            view.setNeedsLayout()
            view.layoutIfNeeded()
            
            super.viewDidLayoutSubviews()
        }
    }
    
    func tapAction() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func favoriteAction() {
        if isFavorited {
            starImageView.image = UIImage(named: "star")
        } else {
            starImageView.image = UIImage(named: "star-filled")
            let explode = FavoriteAnimationView(frame:starImageView.frame)
            view.addSubview(explode)
        }
        
        isFavorited = !isFavorited
    }
}
