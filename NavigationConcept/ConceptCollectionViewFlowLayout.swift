//
//  ConceptCollectionViewFlowLayout.swift
//  NavigationConcept
//
//  Created by crebel on 3/7/16.
//  Copyright © 2016 Rentpath. All rights reserved.
//

import UIKit

@objc
protocol ConceptCollectionViewFlowLayoutDelegate {
    
    optional func conceptCollectionViewFlowLayout(conceptCollectionViewFlowLayout: ConceptCollectionViewFlowLayout, didChangePage page: Int)
}

class ConceptCollectionViewFlowLayout: UICollectionViewFlowLayout {

    var targetX: CGFloat = 0.0
    var currentPage = 0
    
    weak var delegate: ConceptCollectionViewFlowLayoutDelegate?
    
    override func prepareLayout() {
        super.prepareLayout()
        
        guard let _collectionView = collectionView else {
            return
        }
        
        let agentCount = _collectionView.numberOfItemsInSection(0)
        
        guard agentCount > 0 else {
            return
        }
        
        var indexPath = NSIndexPath(forItem: 0, inSection: 0)
        guard let firstAgentLayoutAttributes = layoutAttributesForItemAtIndexPath(indexPath) else {
            return
        }
        
        let collectionViewFrameWidth = CGRectGetWidth(_collectionView.frame)
        let leftPadding = (collectionViewFrameWidth - ceil(CGRectGetWidth(firstAgentLayoutAttributes.frame))) / 2.0
        
        indexPath = NSIndexPath(forItem: agentCount - 1, inSection: 0)
        guard let lastAgentLayoutAttributes = layoutAttributesForItemAtIndexPath(indexPath) else {
            return
        }
        
        let rightPadding = (collectionViewFrameWidth - ceil(CGRectGetWidth(lastAgentLayoutAttributes.frame))) / 2.0
        
        collectionView?.contentInset = UIEdgeInsetsMake(0.0, leftPadding, 0.0, rightPadding)
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let _collectionView = collectionView else {
            return super.targetContentOffsetForProposedContentOffset(proposedContentOffset)
        }
        
        guard let attributesForVisibleCells = self.layoutAttributesForElementsInRect(_collectionView.bounds) else {
            return super.targetContentOffsetForProposedContentOffset(proposedContentOffset)
        }
        
        targetX = proposedContentOffset.x
        var distance: CGFloat = CGFloat.max
        
        for attribute in attributesForVisibleCells {
            
            let adjustedTargetX = attribute.center.x - (CGRectGetWidth(_collectionView.bounds) * 0.5)
            let possibleDistance = CGFloat(fabsf(Float(proposedContentOffset.x - adjustedTargetX)))
            
            if possibleDistance < distance {
                distance = possibleDistance
                targetX = adjustedTargetX
            }
        }
        
        let targetPage = Int(floor((targetX + _collectionView.contentInset.left) / 292.0))
        if targetPage != currentPage {
            currentPage = targetPage
            delegate?.conceptCollectionViewFlowLayout?(self, didChangePage: currentPage)
        }
       
        return CGPoint(x: targetX, y: proposedContentOffset.y)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let _collectionView = collectionView else {
            return super.layoutAttributesForElementsInRect(rect)
        }
        
        guard let attributesForVisibleCells = super.layoutAttributesForElementsInRect(rect) else {
            return nil
        }
        
        for attribute in attributesForVisibleCells {
            if let layoutAttribute = attribute as? ConceptCollectionViewLayoutAttributes {
                layoutAttribute.distanceFromCenter = attribute.center.x - CGRectGetMidX(_collectionView.bounds)
            }
        }

        return attributesForVisibleCells
    }
        
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override class func layoutAttributesClass() -> AnyClass {
        return ConceptCollectionViewLayoutAttributes.self
    }
}
