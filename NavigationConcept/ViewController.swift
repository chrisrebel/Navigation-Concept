//
//  ViewController.swift
//  NavigationConcept
//
//  Created by crebel on 3/7/16.
//  Copyright © 2016 Rentpath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var header: UIView!
    @IBOutlet weak var subHeader: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var pageCount: ConceptPageCount!
    @IBOutlet weak var footer: UIView!
    
    var listings: [Listing] = []
    
    var conceptCollectionViewController: ConceptCollectionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.translucent = true
        navigationController?.view.backgroundColor = UIColor.clearColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didShowDetails", name: "didShowDetails", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "willHideDetails", name: "willHideDetails", object: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ConceptCollectionViewController" {
            conceptCollectionViewController = segue.destinationViewController as! ConceptCollectionViewController
        }
    }
    
//    func createListings() -> [Listing] {
//        
//    }
//    
//    func createReview() -> Review {
//        
//    }
//    
//    func createPerson() -> Person {
//        
//    }
    
    func didShowDetails() {
        header.hidden = true
        UIView.animateWithDuration(0.3, animations: {
            self.footer.transform = CGAffineTransformMakeTranslation(0.0, 50.0)
        })
    }
    
    func willHideDetails() {
        header.hidden = false
        footer.transform = CGAffineTransformIdentity
    }
}
