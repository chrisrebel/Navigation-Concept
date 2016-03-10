//
//  FavoriteAnimationView.swift
//  NavigationConcept
//
//  Created by crebel on 3/10/16.
//  Copyright © 2016 Rentpath. All rights reserved.
//

import UIKit

class FavoriteAnimationView: UIView {

    private var emitter:CAEmitterLayer!
    
    override class func layerClass() -> AnyClass {
        return CAEmitterLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createEmitter()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createEmitter()
    }
    
    func createEmitter() {
        emitter = self.layer as! CAEmitterLayer
        emitter.emitterPosition = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
        emitter.emitterSize = self.bounds.size
        emitter.emitterMode = kCAEmitterLayerAdditive
        emitter.emitterShape = kCAEmitterLayerRectangle
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if self.superview == nil {
            return
        }
        
        let texture:UIImage? = UIImage(named:"star-filled-small")
        assert(texture != nil, "particle image not found")
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = texture!.CGImage
        emitterCell.name = "cell"
        emitterCell.birthRate = 25
        emitterCell.lifetime = 0.75
        emitterCell.alphaRange = 0.5
        emitterCell.velocity = 160
        emitterCell.velocityRange = 40
        emitterCell.scaleRange = 1.5
        emitterCell.scaleSpeed = -0.2
        emitterCell.emissionRange = CGFloat(M_PI*2)
        emitter.emitterCells = [emitterCell]
        
        //disable the emitter
        var delay = Int64(0.1 * Double(NSEC_PER_SEC))
        var delayTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.disableEmitterCell()
        }
        
        //remove explosion view
        delay = Int64(2 * Double(NSEC_PER_SEC))
        delayTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.removeFromSuperview()
        }
    }
    
    func disableEmitterCell() {
        emitter.setValue(0, forKeyPath: "emitterCells.cell.birthRate")
    }
}
