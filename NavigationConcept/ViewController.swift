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
    
    var conceptCollectionViewController: ConceptCollectionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didShowDetails", name: "didShowDetails", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "willHideDetails", name: "willHideDetails", object: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ConceptCollectionViewController" {
            conceptCollectionViewController = segue.destinationViewController as! ConceptCollectionViewController
            conceptCollectionViewController.listings = createListings()
        }
    }
    
    func createListings() -> [Listing] {
        var listings: [Listing] = []
        listings.append(Listing(name: "NEW YORK", image: "new-york", address: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", reviews: [], beds: "40.7127°", baths: "74.0059°"))
        listings.append(Listing(name: "SAN FRANCISCO", image: "san-fran", address: "Proin faucibus odio ut lectus euismod sodales donec mollis vitae.", reviews: [], beds: "37.7833°", baths: "122.4167°"))
        listings.append(Listing(name: "DENVER", image: "denver", address: "Morbi in tincidunt lacus, nec faucibus ante. In blandit nulla lorem.", reviews: [], beds: "39.7392°", baths: "104.9903°"))
        listings.append(Listing(name: "MIAMI", image: "miami", address: "Sed non dui sed nibh blandit blandit non non nulla.", reviews: [], beds: "25.7753°", baths: "80.2089°"))
        return listings
    }
    
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
