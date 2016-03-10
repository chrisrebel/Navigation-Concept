//
//  ConceptCollectionViewCell.swift
//  NavigationConcept
//
//  Created by crebel on 3/7/16.
//  Copyright © 2016 Rentpath. All rights reserved.
//

import UIKit

class ConceptCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoContainerView: UIView!
    @IBOutlet weak var photoContainerViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoContainerViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoContainerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoShadowImageView: UIImageView!
    
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var infoContainerViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoContainerViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoContainerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoShadowImageView: UIImageView!
    
    @IBOutlet weak var profileImage1: UIImageView!
    @IBOutlet weak var profileImage2: UIImageView!
    @IBOutlet weak var profileImage3: UIImageView!
    
    @IBOutlet weak var listingTitleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    var isExpanded = false
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        if let attributes = layoutAttributes as? ConceptCollectionViewLayoutAttributes {
            let absDistance = CGFloat(fabsf(Float(attributes.distanceFromCenter)))
            
            photoContainerView.alpha = max(((200.0 - absDistance) / 200.0), 0.0) + 0.5
            photoShadowImageView.alpha = max(((200.0 - absDistance) / 200.0), 0.0) * 0.2

            let scaleOffset = max(((200.0 - absDistance) / 200.0), 0.0) * 0.05
            let targetScale = 0.95 + scaleOffset

            transform = CGAffineTransformMakeScale(targetScale, targetScale)
        }
    }
    
    override func awakeFromNib() {
        infoShadowImageView.alpha = 0.0
        infoContainerView.alpha = 0.0
    }
    
    override func prepareForReuse() {
        collapse(false)
    }
    
    func expand() {
        isExpanded = true
        photoContainerViewTopConstraint.constant = 0.0
        infoContainerViewLeadingConstraint.constant = 0.0
        infoContainerViewTrailingConstraint.constant = 0.0
        
        UIView.animateWithDuration(0.4, animations: {
            self.layoutIfNeeded()
            self.infoShadowImageView.alpha = 0.2
            self.infoContainerView.alpha = 1.0
        })
    }
    
    func collapse(animated: Bool = true) {
        isExpanded = false
        photoContainerViewTopConstraint.constant = 100.0
        infoContainerViewLeadingConstraint.constant = 15.0
        infoContainerViewTrailingConstraint.constant = 15.0
        
        UIView.animateWithDuration((animated ? 0.4 : 0.0), animations: {
            self.layoutIfNeeded()
            self.infoShadowImageView.alpha = 0.0
            self.infoContainerView.alpha = 0.0
        })
    }
}
