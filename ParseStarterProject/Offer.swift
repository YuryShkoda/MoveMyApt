//
//  Offer.swift
//  moveMyStuff
//
//  Created by Yury on 9/3/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation
import Parse

class Offer {
    
    var id: String?
    var moverID = Mover.sharedInstance.id
    var moverName = Mover.sharedInstance.name
    var order = Order()
    var status: String?
    var total: Int?
    
    init(status: String? = nil, total: Int? = nil) {
        self.status = status
        self.total  = total
    }
    
    func save() {
        
        let offer = PFObject(className: "MoveMyStuff_offers")
        offer["MoverID"]    = self.moverID
        offer["OrderID"]    = order.id
        offer["CustomerID"] = order.customerID
        offer["MoverName"]  = self.moverName
        offer["Status"]     = self.status
        offer["Total"]      = self.total
        
        let acl = PFACL()
        acl.getPublicReadAccess  = true
        acl.getPublicWriteAccess = true
        
        offer.saveInBackground { (success, error) in
            if error != nil {
                var errorMessage = "Saving Offer failed!!!"
                let error = error as NSError?
                
                if let parseError = error?.userInfo["error"] as? String {
                    errorMessage = parseError
                }
                //TODO: show error to user
                print(errorMessage)
            } else {
                self.id = offer.objectId
            }
        }
    }
}
