//
//  OfferDetailsVC.swift
//  moveMyStuff
//
//  Created by Yury on 9/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class OfferDetailsVC: UIViewController {
    
    var offer = Offer()
    var order = Order()
    let dataController = DataController()
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var pickupAddress: UILabel!
    @IBOutlet weak var pickupStairs: UILabel!
    @IBOutlet weak var dropoffAddress: UILabel!
    @IBOutlet weak var dropoffStairs: UILabel!
    @IBOutlet weak var stuffToMove: UILabel!
    @IBOutlet weak var mover: UILabel!
    @IBOutlet weak var offerTotal: UILabel!
    
    @IBAction func accept(_ sender: Any) {
        dataController.processOffer(offerID: offer.id!, status: "Accepted")
    }
    
    @IBAction func decline(_ sender: Any) {
        dataController.processOffer(offerID: offer.id!, status: "Declined")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if offer.id != nil {
            dataController.getOrder(orderID: offer.orderID!)
            self.mover.text = offer.moverName
            self.offerTotal.text = "$" + String(describing: offer.total!)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: Notification.Name("refreshOfferDetails"), object: nil)
    }
    
    func refresh() {
        self.order = dataController.order
        date.text = order.date
        pickupAddress.text = "From: " + order.pickUpAddress!
        if order.pickUpStairs! { pickupStairs.text = "Stairs at pickup" } else { pickupStairs.text = "No stairs at pickup" }
        dropoffAddress.text = "To: " + order.dropOffAddress!
        if order.dropOffStairs! { dropoffStairs.text = "Stairs at dropoff" } else { dropoffStairs.text = "No stairs at dropoff" }
        stuffToMove.text = "Stuff to move: " + order.stuff!
        dropoffAddress.text = order.dropOffAddress
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
