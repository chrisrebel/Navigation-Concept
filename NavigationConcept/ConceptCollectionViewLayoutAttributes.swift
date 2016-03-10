//
//  ConceptCollectionViewLayoutAttributes.swift
//  NavigationConcept
//
//  Created by crebel on 3/8/16.
//  Copyright © 2016 Rentpath. All rights reserved.
//

import UIKit

class ConceptCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var distanceFromCenter: CGFloat = 0.0
    var distanceFromRightEdge: CGFloat = 0.0
    var distanceFromLeftEdge: CGFloat = 0.0
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = super.copyWithZone(zone) as! ConceptCollectionViewLayoutAttributes
        copy.distanceFromCenter = distanceFromCenter
        copy.distanceFromLeftEdge = distanceFromLeftEdge
        copy.distanceFromRightEdge = distanceFromRightEdge
        return copy
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let attributes = object as? ConceptCollectionViewLayoutAttributes else {
            return false
        }
        
        if attributes.distanceFromCenter == distanceFromCenter &&
            attributes.distanceFromLeftEdge == distanceFromLeftEdge &&
            attributes.distanceFromRightEdge == distanceFromRightEdge {
            return super.isEqual(object)
        } else {
            return false
        }
    }
}
