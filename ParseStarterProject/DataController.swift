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
    var order = Order()
    
    func getActiveOrders() {
        
        let  query = PFQuery(className: "MoveMyStuff_orders")
        query.whereKey("Status", notEqualTo: "Deleted")
        
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
                                let newOrder = Order(id: order.objectId, customerID: order["CustomerID"] as! String, status: order["Status"] as! String, email: order["Email"] as! String, date: order["Date"] as! String, pickUpAddress: order["PickUpAddress"] as! String, dropOffAddress: order["DropOffAddress"] as! String, pickUpStairs: order["PickUpStairs"] as! Bool, dropOffStairs: order["DropOffStairs"] as! Bool, stuff: order["Stuff"] as! String)
                                self.orders.append(newOrder)
                            }
                        }
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshOrdersList"), object: nil)
                    }
                }
            }
        }
    }
    
    func getOrder(orderID: String) {
        
        let query = PFQuery(className: "MoveMyStuff_orders")
        query.whereKey("objectId", equalTo: orderID)
        query.findObjectsInBackground { (objects, error) in
            
            if error != nil {
                var errorMessage = "Error while getting order!!!"
                let error = error as NSError?
                
                if let parseError = error?.userInfo["error"] as? String {
                    errorMessage = parseError
                }
                //TODO: show error to user
                print(errorMessage)
            } else {
                if let orders = objects {
                    if orders.count > 0 {
                        for object in orders {
                            if let order = object as? PFObject {
                                let newOrder = Order(id: order.objectId, customerID: order["CustomerID"] as! String, status: order["Status"] as! String, email: order["Email"] as! String, date: order["Date"] as! String, pickUpAddress: order["PickUpAddress"] as! String, dropOffAddress: order["DropOffAddress"] as! String, pickUpStairs: order["PickUpStairs"] as! Bool, dropOffStairs: order["DropOffStairs"] as! Bool, stuff: order["Stuff"] as! String)
                                self.order = newOrder
                            }
                        }
                        NotificationCenter.default.post(name: NSNotification.Name("refreshOfferDetails"), object: nil)
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
                                
                                let newOffer        = Offer(status: offer["Status"] as? String, total: offer["Total"] as? Int)
                                newOffer.id         = offer.objectId
                                newOffer.moverID    = offer["MoverID"] as? String
                                newOffer.moverName  = offer["MoverName"] as? String
                                newOffer.orderID    = offer["OrderID"] as? String
                                newOffer.customerID = offer["CustomerID"] as? String
                                
                                self.offers.append(newOffer)
                            }
                        }
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshOffersList"), object: nil)
                    }
                }
            }
        }
    }
    
    func getOffers(moverID: String) {
        let query = PFQuery(className: "MoveMyStuff_offers")
        query.whereKey("MoverID", equalTo: moverID)
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
                                
                                let newOffer        = Offer(status: offer["Status"] as? String, total: offer["Total"] as? Int)
                                newOffer.id         = offer.objectId
                                newOffer.moverID    = offer["MoverID"] as? String
                                newOffer.moverName  = offer["MoverName"] as? String
                                newOffer.orderID    = offer["OrderID"] as? String
                                newOffer.customerID = offer["CustomerID"] as? String
                                
                                self.offers.append(newOffer)
                            }
                        }
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshOffersList"), object: nil)
                    }
                }
            }
        }
    }
    
    func processOffer(offerID: String, status: String) {
        let query = PFQuery(className: "MoveMyStuff_offers")
        query.whereKey("objectId", equalTo: offerID)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                var errorMessage = "Error while processing offer!!!"
                let error = error as NSError?
                
                if let parseError = error?.userInfo["error"] as? String {
                    errorMessage = parseError
                }
                //TODO: show error to user
                print(errorMessage)
            } else {
                if let offers = objects {
                    if offers.count > 0 {
                        for object in offers {
                            if let offer = object as? PFObject {
                                offer.setValue(status, forKey: "Status")
                                offer.saveInBackground(block: { (success, error) in
                                    if error != nil {
                                        var errorMessage = "Error while accepting offer!!!"
                                        let error = error as NSError?
                                        
                                        if let parseError = error?.userInfo["error"] as? String {
                                            errorMessage = parseError
                                        }
                                        //TODO: show error to user
                                        print(errorMessage)
                                    } else {
                                        if status == "Accepted" {
                                            self.declineAllOffers(forOrder: offer["OrderID"] as! String, exceptID: offerID)
                                            self.processOrder(orderID: offer["OrderID"] as! String, status: "Completed")
                                        }
                                    }
                                })
                            }
                        }
                    }
                }
            }
        }
    }
    
    func processOrder(orderID: String, status: String) {
        let query = PFQuery(className: "MoveMyStuff_orders")
        query.whereKey("objectId", equalTo: orderID)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                var errorMessage = "Error while processing order!!!"
                let error = error as NSError?
                
                if let parseError = error?.userInfo["error"] as? String {
                    errorMessage = parseError
                }
                //TODO: show error to user
                print(errorMessage)
            } else {
                if let orders = objects {
                    if orders.count > 0 {
                        for object in orders {
                            if let order = object as? PFObject {
                                order.setValue(status, forKey: "Status")
                                order.saveInBackground()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func declineAllOffers(forOrder: String, exceptID: String) {
        let query = PFQuery(className: "MoveMyStuff_offers")
        query.whereKey("OrderID", equalTo: forOrder)
        query.whereKey("objectId", notEqualTo: exceptID)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                var errorMessage = "Error while getting offer for order!!!"
                let error = error as NSError?
                
                if let parseError = error?.userInfo["error"] as? String {
                    errorMessage = parseError
                }
                //TODO: show error to user
                print(errorMessage)
            } else {
                if let offers = objects {
                    if offers.count > 0 {
                        for object in offers {
                            if let offer = object as? PFObject {
                                offer.setValue("Declined", forKey: "Status")
                                offer.saveInBackground()
                            }
                        }
                    }
                }
            }
        }
    }
}
