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
    
    var review1ProfileViewStartingFrame = CGRectZero
    var review1ProfileViewEndingFrame = CGRectZero
    var review1ProfileView: UIImageView!
    var review1: UIView!
    
    var review2ProfileViewStartingFrame = CGRectZero
    var review2ProfileViewEndingFrame = CGRectZero
    var review2ProfileView: UIImageView!
    var review2: UIView!
    
    var review3ProfileViewStartingFrame = CGRectZero
    var review3ProfileViewEndingFrame = CGRectZero
    var review3ProfileView: UIImageView!
    var review3: UIView!
    
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
        
        review1ProfileView.frame = review1ProfileViewStartingFrame
        view.addSubview(review1ProfileView)
        
        review2ProfileView.frame = review2ProfileViewStartingFrame
        view.addSubview(review2ProfileView)
        
        review3ProfileView.frame = review3ProfileViewStartingFrame
        view.addSubview(review3ProfileView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animateIn()
        delegate?.conceptDetailAnimationTransitionViewControllerDelegateDidStartAnimateIn?(self)
    }

    func animateIn() {
        
        let timeOffset = 0.0
        
        conceptDetailViewController.review1ProfileImage.hidden = true
        review1 = conceptDetailViewController.review1.snapshotViewAfterScreenUpdates(false)
        view.insertSubview(review1, belowSubview: mapViewContainer)
        conceptDetailViewController.review1ProfileImage.hidden = false
        
        let review1EndingFrame = conceptDetailViewController.review1.frame
        let review1StartingFrame = CGRectMake(review1EndingFrame.origin.x, review1EndingFrame.origin.y - 50.0, review1EndingFrame.size.width, review1EndingFrame.size.height)
        review1.frame = review1StartingFrame
        review1.alpha = 0.0
        
        conceptDetailViewController.review2ProfileImage.hidden = true
        review2 = conceptDetailViewController.review2.snapshotViewAfterScreenUpdates(false)
        view.insertSubview(review2, belowSubview: mapViewContainer)
        conceptDetailViewController.review2ProfileImage.hidden = false
        
        let review2EndingFrame = conceptDetailViewController.review2.frame
        let review2StartingFrame = CGRectMake(review2EndingFrame.origin.x, review2EndingFrame.origin.y - 50.0, review2EndingFrame.size.width, review2EndingFrame.size.height)
        review2.frame = review2StartingFrame
        review2.alpha = 0.0
        
        conceptDetailViewController.review3ProfileImage.hidden = true
        review3 = conceptDetailViewController.review3.snapshotViewAfterScreenUpdates(false)
        view.insertSubview(review3, belowSubview: mapViewContainer)
        conceptDetailViewController.review3ProfileImage.hidden = false
        
        let review3EndingFrame = conceptDetailViewController.review3.frame
        let review3StartingFrame = CGRectMake(review3EndingFrame.origin.x, review3EndingFrame.origin.y - 50.0, review3EndingFrame.size.width, review3EndingFrame.size.height)
        review3.frame = review3StartingFrame
        review3.alpha = 0.0
        
        let addressLabelEndingFrameOrigin = conceptDetailViewController.addressLabel.superview!.convertRect(conceptDetailViewController.addressLabel.frame, toCoordinateSpace: conceptDetailViewController.addressLabel.window!).origin
        
        addressLabelEndingFrame = CGRectMake(addressLabelEndingFrameOrigin.x, addressLabelEndingFrameOrigin.y, CGRectGetWidth(addressLabelStartingFrame), CGRectGetHeight(addressLabelStartingFrame))
        
        let ratingsImageViewEndingFrameOrigin = conceptDetailViewController.ratingImageView.superview!.convertRect(conceptDetailViewController.ratingImageView.frame, toCoordinateSpace: conceptDetailViewController.ratingImageView.window!).origin
        
        ratingsImageViewEndingFrame = CGRectMake(ratingsImageViewEndingFrameOrigin.x, ratingsImageViewEndingFrameOrigin.y, CGRectGetWidth(ratingsImageViewStartingFrame), CGRectGetHeight(ratingsImageViewStartingFrame))
        
        let review1ProfileViewEndinigFrameOrigin = conceptDetailViewController.review1ProfileImage.superview!.convertRect(conceptDetailViewController.review1ProfileImage.frame, toCoordinateSpace: conceptDetailViewController.review1ProfileImage.window!).origin
        
        review1ProfileViewEndingFrame = CGRectMake(review1ProfileViewEndinigFrameOrigin.x, review1ProfileViewEndinigFrameOrigin.y, CGRectGetWidth(review1ProfileViewStartingFrame), CGRectGetHeight(review1ProfileViewStartingFrame))
        
        let review2ProfileViewEndinigFrameOrigin = conceptDetailViewController.review2ProfileImage.superview!.convertRect(conceptDetailViewController.review2ProfileImage.frame, toCoordinateSpace: conceptDetailViewController.review2ProfileImage.window!).origin
        
        review2ProfileViewEndingFrame = CGRectMake(review2ProfileViewEndinigFrameOrigin.x, review2ProfileViewEndinigFrameOrigin.y, CGRectGetWidth(review2ProfileViewStartingFrame), CGRectGetHeight(review2ProfileViewStartingFrame))
        
        let review3ProfileViewEndinigFrameOrigin = conceptDetailViewController.review3ProfileImage.superview!.convertRect(conceptDetailViewController.review3ProfileImage.frame, toCoordinateSpace: conceptDetailViewController.review3ProfileImage.window!).origin
        
        review3ProfileViewEndingFrame = CGRectMake(review3ProfileViewEndinigFrameOrigin.x, review3ProfileViewEndinigFrameOrigin.y, CGRectGetWidth(review3ProfileViewStartingFrame), CGRectGetHeight(review3ProfileViewStartingFrame))
            
        UIView.animateWithDuration(0.6 + timeOffset, animations: {
            self.addressLabelImageView.frame = self.addressLabelEndingFrame
            self.ratingsImageView.frame = self.ratingsImageViewEndingFrame
            self.review1ProfileView.frame = self.review1ProfileViewEndingFrame
            self.review2ProfileView.frame = self.review2ProfileViewEndingFrame
            self.review3ProfileView.frame = self.review3ProfileViewEndingFrame
        })
        
        UIView.animateWithDuration(0.3 + timeOffset, delay: 0.3,
            options: [UIViewAnimationOptions.CurveEaseOut], animations: {
                self.review1.frame = review1EndingFrame
                self.review1.alpha = 1.0
                self.review2.frame = review2EndingFrame
                self.review2.alpha = 1.0
                self.review3.frame = review3EndingFrame
                self.review3.alpha = 1.0
            }) { (complete) -> Void in
                
        }
        
        photoContainerViewHeightConstraint.constant = CGRectGetMaxY(photoContainerViewStartingFrame)
        photoContainerViewTopConstraint.constant = 0.0
        
        UIView.animateWithDuration(0.6 + timeOffset, delay: 0.0,
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
        
        UIView.animateWithDuration(0.6 + timeOffset, delay: 0.0,
            options: [UIViewAnimationOptions.CurveEaseOut], animations: {
                self.view.layoutIfNeeded()
                self.mapViewContainer.alpha = 1.0
            }) { (complete) -> Void in
                self.removeViews()
        }


        photoContainerViewHeightConstraint.constant = 250.0
        listingTitleLabelTopConstraint.constant -= 50.0
        
        UIView.animateWithDuration(0.6 + timeOffset, delay: 0.0,
            options: [UIViewAnimationOptions.CurveEaseOut], animations: {
                self.view.layoutIfNeeded()
                self.listingTitleLabel.alpha = 0.0
            }, completion: nil)
        
        
        UIView.animateWithDuration(0.3 + timeOffset, animations: {
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
        self.review1ProfileView.removeFromSuperview()
        self.review2ProfileView.removeFromSuperview()
        self.review3ProfileView.removeFromSuperview()
        self.review1.removeFromSuperview()
        self.review2.removeFromSuperview()
        self.review3.removeFromSuperview()
        self.review1ProfileView.removeFromSuperview()
        self.review2ProfileView.removeFromSuperview()
        self.review3ProfileView.removeFromSuperview()
        self.delegate?.conceptDetailAnimationTransitionViewControllerDidCompleteAnimateIn?(self)
        self.containerView.hidden = false
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ConceptDetailViewController" {
            conceptDetailViewController = segue.destinationViewController as! ConceptDetailViewController
        }
    }
}
