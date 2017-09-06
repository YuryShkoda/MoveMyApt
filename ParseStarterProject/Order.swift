//
//  Order.swift
//  MoveMyStuff
//
//  Created by Yury on 8/7/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation
import Parse

class Order {
    
    var id: String?
    var status: String?
    let customerID: String?
    var email: String?
    var stuff: String?
    var date: String?
    var pickUpAddress: String?
    var dropOffAddress: String?
    var pickUpStairs: Bool?
    var dropOffStairs: Bool?
    
    init(id: String? = nil, customerID: String? = nil, status: String? = nil, email: String? = nil, date: String? = nil, pickUpAddress: String? = nil, dropOffAddress: String? = nil, pickUpStairs: Bool? = nil, dropOffStairs: Bool? = nil, stuff: String? = nil) {
        
        self.id = id
        self.customerID = customerID
        self.status = status
        self.email = email
        self.date = date
        self.pickUpAddress = pickUpAddress
        self.dropOffAddress = dropOffAddress
        self.pickUpStairs = pickUpStairs
        self.dropOffStairs = dropOffStairs
        self.stuff = stuff
    }
    
    func save() {
        
        let order = PFObject(className: "MoveMyStuff_orders")
        order["CustomerID"]     = self.customerID
        order["Status"]         = self.status
        order["Email"]          = self.email
        order["Date"]           = self.date
        order["PickUpAddress"]  = self.pickUpAddress
        order["DropOffAddress"] = self.dropOffAddress
        order["PickUpStairs"]   = self.pickUpStairs
        order["DropOffStairs"]  = self.dropOffStairs
        order["Stuff"]          = self.stuff
        
//        let acl = PFACL()
//        acl.getPublicReadAccess  = true
//        acl.getPublicWriteAccess = true
        
        order.saveInBackground { (success, error) in
            if error != nil {
                var errorMessage = "Saving Order failed!!!"
                let error = error as NSError?
                
                if let parseError = error?.userInfo["error"] as? String {
                    errorMessage = parseError
                }
                //TODO: show error to user
                print(errorMessage)
            } else {
                self.id = order.objectId
            }
        }
    }
}
