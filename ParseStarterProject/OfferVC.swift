//
//  CreateOffer.swift
//  moveMyStuff
//
//  Created by Yury on 9/3/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class OfferVC: UIViewController, UITextFieldDelegate {
    
    var order = Order()
    var offer = Offer()
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var pickupAddress: UILabel!
    @IBOutlet weak var pickupStairs: UILabel!
    @IBOutlet weak var dropoffAddress: UILabel!
    @IBOutlet weak var dropoffStairs: UILabel!
    @IBOutlet weak var stuffToMove: UILabel!
    @IBOutlet weak var offerTotal: UITextField!

    @IBAction func createOffer(_ sender: Any) {
        if offerTotal.text != "" {
            offer.status = "Pending"
            offer.total  = Int(offerTotal.text!)
            offer.order  = order
            offer.save()
        } else {
            offerTotal.layer.borderWidth = 1
            offerTotal.layer.borderColor = UIColor.red.cgColor
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        offerTotal.delegate = self
        
        if order.customerID != nil {
            
            date.text = order.date
            pickupAddress.text = "From: " + order.pickUpAddress!
            if order.pickUpStairs! { pickupStairs.text = "Stairs at pickup" } else { pickupStairs.text = "No stairs at pickup" }
            dropoffAddress.text = "To: " + order.dropOffAddress!
            if order.dropOffStairs! { dropoffStairs.text = "Stairs at dropoff" } else { dropoffStairs.text = "No stairs at dropoff" }
            stuffToMove.text = "Stuff to move: " + order.stuff!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
