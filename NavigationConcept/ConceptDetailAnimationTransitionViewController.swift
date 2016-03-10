//
//  ConceptDetailAnimationTransitionViewController.swift
//  NavigationConcept
//
//  Created by crebel on 3/9/16.
//  Copyright © 2016 Rentpath. All rights reserved.
//

import UIKit

@objc
protocol ConceptDetailAnimationTransitionViewControllerDelegate {
    
    optional func conceptDetailAnimationTransitionViewControllerDelegateDidStartAnimateIn(conceptDetailAnimationTransitionViewController: ConceptDetailAnimationTransitionViewController)
    optional func conceptDetailAnimationTransitionViewControllerDidCompleteAnimateIn(conceptDetailAnimationTransitionViewController: ConceptDetailAnimationTransitionViewController)
}

class ConceptDetailAnimationTransitionViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var photoContainerView: UIView!
    @IBOutlet weak var photoContainerViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoContainerViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoContainerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoContainerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var infoContainerViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoContainerViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoContainerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoContainerViewBottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var photoShadowImageView: UIImageView!
    @IBOutlet weak var photoShadowImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoShadowImageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoShadowImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoShadowImageViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mapViewContainer: UIView!
    @IBOutlet weak var mapViewContainerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapViewContainerTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapViewContainerTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var listingTitleLabel: UILabel!
    @IBOutlet weak var listingTitleLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var listingTitleLabelTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var listingTitleLabelTopConstraint: NSLayoutConstraint!
    
    var conceptDetailViewController: ConceptDetailViewController!
    
    var photoContainerViewStartingFrame = CGRectZero
    var photoContainerViewEndingFrame = CGRectZero
    
    var infoContainerViewStartingFrame = CGRectZero
    var infoContainerViewEndingFrame = CGRectZero
    
    var addressLabelStartingFrame = CGRectZero
    var addressLabelEndingFrame = CGRectZero
    var addressLabelImageView: UIImageView!
    
    var ratingsImageViewStartingFrame = CGRectZero
    var ratingsImageViewEndingFrame = CGRectZero
    var ratingsImageView: UIImageView!
    
    var photoShadowImageViewStartingFrame = CGRectZero
    var photoShadowImageViewEndingFrame = CGRectZero
    
    var listingTitleLabelStartingFrame = CGRectZero
    
    weak var delegate: ConceptDetailAnimationTransitionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.hidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        photoContainerViewTopConstraint.constant = photoContainerViewStartingFrame.origin.y
        photoContainerViewHeightConstraint.constant = photoContainerViewStartingFrame.size.height
        photoContainerViewLeadingConstraint.constant = photoContainerViewStartingFrame.origin.x
        photoContainerViewTrailingConstraint.constant = photoContainerViewStartingFrame.origin.x

        photoShadowImageViewTopConstraint.constant = photoShadowImageViewStartingFrame.origin.y
        photoShadowImageViewLeadingConstraint.constant = photoShadowImageViewStartingFrame.origin.x
        photoShadowImageViewTrailingConstraint.constant = photoShadowImageViewStartingFrame.origin.x
        photoShadowImageViewHeightConstraint.constant = photoShadowImageViewStartingFrame.size.height
        
        infoContainerViewTopConstraint.constant = infoContainerViewStartingFrame.origin.y
        infoContainerViewBottomConstraint.constant = CGRectGetHeight(view.frame) - CGRectGetMaxY(infoContainerViewStartingFrame)
        infoContainerViewLeadingConstraint.constant = infoContainerViewStartingFrame.origin.x
        infoContainerViewTrailingConstraint.constant = infoContainerViewStartingFrame.origin.x
        
        mapViewContainerTopConstraint.constant = infoContainerViewStartingFrame.origin.y
        mapViewContainerLeadingConstraint.constant = infoContainerViewLeadingConstraint.constant
        mapViewContainerTrailingConstraint.constant = infoContainerViewTrailingConstraint.constant
        mapViewContainer.alpha = 0.0
        
        listingTitleLabelTopConstraint.constant = listingTitleLabelStartingFrame.origin.y
        
        addressLabelImageView.frame = addressLabelStartingFrame
        view.addSubview(addressLabelImageView)
        
        ratingsImageView.frame = ratingsImageViewStartingFrame
        view.addSubview(ratingsImageView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animateIn()
        delegate?.conceptDetailAnimationTransitionViewControllerDelegateDidStartAnimateIn?(self)
    }

    func animateIn() {
        
        let addressLabelEndingFrameOrigin = conceptDetailViewController.addressLabel.superview!.convertRect(conceptDetailViewController.addressLabel.frame, toCoordinateSpace: conceptDetailViewController.addressLabel.window!).origin
        
        addressLabelEndingFrame = CGRectMake(addressLabelEndingFrameOrigin.x, addressLabelEndingFrameOrigin.y, CGRectGetWidth(addressLabelStartingFrame), CGRectGetHeight(addressLabelStartingFrame))
        
        let ratingsImageViewEndingFrameOrigin = conceptDetailViewController.ratingImageView.superview!.convertRect(conceptDetailViewController.ratingImageView.frame, toCoordinateSpace: conceptDetailViewController.ratingImageView.window!).origin
        
        ratingsImageViewEndingFrame = CGRectMake(ratingsImageViewEndingFrameOrigin.x, ratingsImageViewEndingFrameOrigin.y, CGRectGetWidth(ratingsImageViewStartingFrame), CGRectGetHeight(ratingsImageViewStartingFrame))
            
        UIView.animateWithDuration(0.7, animations: {
            self.addressLabelImageView.frame = self.addressLabelEndingFrame
            self.ratingsImageView.frame = self.ratingsImageViewEndingFrame
        })
        
        photoContainerViewHeightConstraint.constant = CGRectGetMaxY(photoContainerViewStartingFrame)
        photoContainerViewTopConstraint.constant = 0.0
        
        UIView.animateWithDuration(0.7, delay: 0.0,
            options: [UIViewAnimationOptions.CurveEaseInOut], animations: {
                self.view.layoutIfNeeded()
            }) { (complete) -> Void in
                
        }

        photoContainerViewLeadingConstraint.constant = 0.0
        photoContainerViewTrailingConstraint.constant = 0.0
        
        photoShadowImageViewLeadingConstraint.constant = 0.0
        photoShadowImageViewTrailingConstraint.constant = 0.0
        photoShadowImageViewHeightConstraint.constant -= 100.0
        
        infoContainerViewBottomConstraint.constant = 0.0
        infoContainerViewLeadingConstraint.constant = 0.0
        infoContainerViewTrailingConstraint.constant = 0.0
        
        mapViewContainerTopConstraint.constant = 250.0
        mapViewContainerLeadingConstraint.constant = 0.0
        mapViewContainerTrailingConstraint.constant = 0.0
        
        UIView.animateWithDuration(0.7, delay: 0.0,
            options: [UIViewAnimationOptions.CurveEaseOut], animations: {
                self.view.layoutIfNeeded()
                self.mapViewContainer.alpha = 1.0
            }) { (complete) -> Void in
                self.removeViews()
        }


        photoContainerViewHeightConstraint.constant = 250.0
        listingTitleLabelTopConstraint.constant -= 50.0
        
        UIView.animateWithDuration(0.7, delay: 0.0,
            options: [UIViewAnimationOptions.CurveEaseOut], animations: {
                self.view.layoutIfNeeded()
                self.listingTitleLabel.alpha = 0.0
            }, completion: nil)
        
        
        UIView.animateWithDuration(0.4, animations: {
            self.photoShadowImageView.alpha = 0.0
        })
    }
    
    func removeViews() {
        self.photoContainerView.removeFromSuperview()
        self.headerView.removeFromSuperview()
        self.infoContainerView.removeFromSuperview()
        self.addressLabelImageView.removeFromSuperview()
        self.ratingsImageView.removeFromSuperview()
        self.mapViewContainer.removeFromSuperview()
        self.listingTitleLabel.removeFromSuperview()
        self.delegate?.conceptDetailAnimationTransitionViewControllerDidCompleteAnimateIn?(self)
        self.containerView.hidden = false
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ConceptDetailViewController" {
            conceptDetailViewController = segue.destinationViewController as! ConceptDetailViewController
        }
    }
}
