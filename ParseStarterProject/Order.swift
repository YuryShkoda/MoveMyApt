//
//  Order.swift
//  MoveMyStuff
//
//  Created by Yury on 8/7/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation

struct Order {
    
    let id: String
    var email: String
    var name: String
    var date: String
    var pickUpAddress: String
    var dropOffAddress: String
    var pickUpStairs: Bool
    var dropOffStairs: Bool
    //var restrictions: String
    //var stuff: [String: Int]
    //var isActive: Bool
    
    init(id: String, email: String, name: String, date: String, pickUpAddress: String, dropOffAddress: String, pickUpStairs: Bool, dropOffStairs: Bool) {
        
        self.id = id
        self.email = email
        self.name = name
        self.date = date
        self.pickUpAddress = pickUpAddress
        self.dropOffAddress = dropOffAddress
        self.pickUpStairs = pickUpStairs
        self.dropOffStairs = dropOffStairs
//        self.restrictions = restrictions
//        self.stuff = stuff
//        self.isActive = isActive
    }
}
