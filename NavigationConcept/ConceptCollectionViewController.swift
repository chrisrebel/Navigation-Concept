//
//  ConceptCollectionViewController.swift
//  NavigationConcept
//
//  Created by crebel on 3/7/16.
//  Copyright © 2016 Rentpath. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

@objc protocol ConceptCollectionViewControllerDelegate {
    
    optional func conceptCollectionViewController(conceptCollectionViewController: ConceptCollectionViewController, didSelectItemAtIndexPath indexPath: NSIndexPath)
}

class ConceptCollectionViewController: UICollectionViewController {

    weak var delegate: ConceptCollectionViewControllerDelegate?
    
    var expandedCell: ConceptCollectionViewCell?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        collectionView!.backgroundColor = UIColor.clearColor()
//        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
        
        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeUp:")
        swipeUpGestureRecognizer.direction = .Up
        
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDownGestureRecognizer.direction = .Down
        
        collectionView!.addGestureRecognizer(swipeUpGestureRecognizer)
        collectionView!.addGestureRecognizer(swipeDownGestureRecognizer)
    }
    
    func swipeUp(swipeGestureRecognizer: UISwipeGestureRecognizer) {
        let point = swipeGestureRecognizer.locationInView(self.view)
        let pointInCollection = CGPointMake(point.x + collectionView!.contentOffset.x, point.y + collectionView!.contentOffset.y)
        
        if let indexPath = collectionView!.indexPathForItemAtPoint(pointInCollection) {
            if let cell = collectionView!.cellForItemAtIndexPath(indexPath) as? ConceptCollectionViewCell {
                if let _expandedCell = expandedCell {
                    if cell != _expandedCell && _expandedCell.isExpanded {
                        _expandedCell.collapse()
                    }
                }
                
                expandedCell = cell
                cell.expand()
            }
        }
    }
    
    func swipeDown(swipeGestureRecognizer: UISwipeGestureRecognizer) {
        let point = swipeGestureRecognizer.locationInView(self.view)
        let pointInCollection = CGPointMake(point.x + collectionView!.contentOffset.x, point.y + collectionView!.contentOffset.y)
        
        if let indexPath = collectionView!.indexPathForItemAtPoint(pointInCollection) {
            if let cell = collectionView!.cellForItemAtIndexPath(indexPath) as? ConceptCollectionViewCell {
                cell.collapse()
            }
        }
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ConceptCollectionViewCell
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ConceptCollectionViewCell
        
        if cell.isExpanded {        
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ConceptDetailAnimationTransitionViewController") as! ConceptDetailAnimationTransitionViewController
            
            let photoContainerViewOrigin = cell.convertRect(cell.photoContainerView.frame, toCoordinateSpace: cell.window!).origin
            controller.photoContainerViewStartingFrame = CGRectMake(photoContainerViewOrigin.x, photoContainerViewOrigin.y, CGRectGetWidth(cell.photoContainerView.frame), CGRectGetHeight(cell.photoContainerView.frame))
            
            let infoContainerViewOrigin = cell.convertRect(cell.infoContainerView.frame, toCoordinateSpace: cell.window!).origin
            controller.infoContainerViewStartingFrame = CGRectMake(infoContainerViewOrigin.x, infoContainerViewOrigin.y, CGRectGetWidth(cell.infoContainerView.frame), CGRectGetHeight(cell.infoContainerView.frame))
            
            let addressLabelOrigin = cell.addressLabel.superview!.convertRect(cell.addressLabel.frame, toCoordinateSpace: cell.window!).origin
            controller.addressLabelStartingFrame = CGRectMake(addressLabelOrigin.x, addressLabelOrigin.y, CGRectGetWidth(cell.addressLabel.frame), CGRectGetHeight(cell.addressLabel.frame))
            controller.addressLabelImageView = UIImageView(image: cell.addressLabel.toImage())
            
            let ratingsImageViewOrigin = cell.ratingImageView.superview!.convertRect(cell.ratingImageView.frame, toCoordinateSpace: cell.window!).origin
            controller.ratingsImageViewStartingFrame = CGRectMake(ratingsImageViewOrigin.x, ratingsImageViewOrigin.y, CGRectGetWidth(cell.ratingImageView.frame), CGRectGetHeight(cell.ratingImageView.frame))
            controller.ratingsImageView = UIImageView(image: cell.ratingImageView.image)
            
            let photoShadowImageViewOrigin = cell.photoShadowImageView.superview!.convertRect(cell.photoShadowImageView.frame, toCoordinateSpace: cell.window!).origin
            controller.photoShadowImageViewStartingFrame = CGRectMake(photoShadowImageViewOrigin.x, photoShadowImageViewOrigin.y, CGRectGetWidth(cell.photoShadowImageView.frame), CGRectGetHeight(cell.photoShadowImageView.frame))
            
            let listingTitleLabelOrigin = cell.listingTitleLabel.superview!.convertRect(cell.listingTitleLabel.frame, toCoordinateSpace: cell.window!).origin
            controller.listingTitleLabelStartingFrame = CGRectMake(listingTitleLabelOrigin.x, listingTitleLabelOrigin.y, CGRectGetWidth(cell.listingTitleLabel.frame), CGRectGetHeight(cell.listingTitleLabel.frame))
            
            controller.delegate = self
            controller.modalPresentationStyle = .OverCurrentContext
            self.modalPresentationStyle = .OverCurrentContext
            presentViewController(controller, animated: false, completion: nil)
            
        } else {
            if let _expandedCell = expandedCell {
                if cell != _expandedCell && _expandedCell.isExpanded {
                    _expandedCell.collapse()
                }
            }
            
            expandedCell = cell
            cell.expand()
        }
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return CGSize(width: 292.0, height: CGRectGetHeight(collectionView!.bounds))
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
}

extension ConceptCollectionViewController: ConceptDetailAnimationTransitionViewControllerDelegate {
    
    func conceptDetailAnimationTransitionViewControllerDelegateDidStartAnimateIn(conceptDetailAnimationTransitionViewController: ConceptDetailAnimationTransitionViewController) {
        collectionView?.hidden = true
        NSNotificationCenter.defaultCenter().postNotificationName("didShowDetails", object: self)
    }
    
    func conceptDetailAnimationTransitionViewControllerDidCompleteAnimateIn(conceptDetailAnimationTransitionViewController: ConceptDetailAnimationTransitionViewController) {
        collectionView?.hidden = false
        NSNotificationCenter.defaultCenter().postNotificationName("willHideDetails", object: self)
    }
}
