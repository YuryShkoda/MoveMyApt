//
//  DataController.swift
//  moveMyStuff
//
//  Created by Yury on 8/27/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation
import Parse

class DataController{
    
    var orders: [Order] = []
    var offers: [Offer] = []
    
    func getActiveOrders() {
        
        let  query = PFQuery(className: "MoveMyStuff_orders")
        query.whereKey("IsActive", equalTo: true)
        query.findObjectsInBackground { (objects, error) in
            
            if error != nil {
                var errorMessage = "Error while getting active orders!!!"
                let error = error as NSError?
                
                if let parseError = error?.userInfo["error"] as? String {
                    errorMessage = parseError
                }
                //TODO: show error to user
                print(errorMessage)
            } else {
                if let orders = objects {
                    if orders.count > 0 {
                        self.orders.removeAll()
                        for object in orders {
                            if let order = object as? PFObject {
                                let newOrder = Order(id: order.objectId, customerID: order["CustomerID"] as! String, isActive: true, email: order["Email"] as! String, date: order["Date"] as! String, pickUpAddress: order["PickUpAddress"] as! String, dropOffAddress: order["DropOffAddress"] as! String, pickUpStairs: order["PickUpStairs"] as! Bool, dropOffStairs: order["DropOffStairs"] as! Bool, stuff: order["Stuff"] as! String)
                                self.orders.append(newOrder)
                            }
                        }
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshOrdersList"), object: nil)
                    }
                }
            }
        }
    }
    
    func getOffers(customerID: String) {
        
        let query = PFQuery(className: "MoveMyStuff_offers")
        query.whereKey("CustomerID", equalTo: customerID)
        query.findObjectsInBackground { (objects, error) in
            
            if error != nil {
                var errorMessage = "Error while getting active offers!!!"
                let error = error as NSError?
                
                if let parseError = error?.userInfo["error"] as? String {
                    errorMessage = parseError
                }
                //TODO: show error to user
                print(errorMessage)
            } else {
                if let offers = objects {
                    if offers.count > 0 {
                        self.offers.removeAll()
                        for object in offers {
                            if let offer = object as? PFObject {
                                
                                let newOffer       = Offer(status: offer["Status"] as? String, total: offer["Total"] as? Int)
                                newOffer.id        = offer.objectId
                                newOffer.moverID   = offer["MoverID"] as? String
                                newOffer.moverName = offer["MoverName"] as? String
                                
                                self.offers.append(newOffer)
                            }
                        }
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshOffersList"), object: nil)
                    }
                }
            }
        }
    }
}
