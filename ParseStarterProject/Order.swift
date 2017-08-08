//
//  Order.swift
//  moveMyApt
//
//  Created by Yury on 8/7/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation

struct Order {
    
    let id: String
    var email: String
    var name: String
    var date: NSDate
    var pickUpAddress: String
    var dropOffAddress: String
    var stairs: Bool
    var restrictions: String
    var stuff: [String: Int]
    var isActive: Bool
    
    init(id: String, email: String, name: String, date: NSDate, pickUpAddress: String, dropOffAddress: String, stairs: Bool, restrictions: String, stuff: [String: Int], isActive: Bool) {
        
        self.id = id
        self.email = email
        self.name = name
        self.date = date
        self.pickUpAddress = pickUpAddress
        self.dropOffAddress = dropOffAddress
        self.stairs = stairs
        self.restrictions = restrictions
        self.stuff = stuff
        self.isActive = isActive
    }
}
