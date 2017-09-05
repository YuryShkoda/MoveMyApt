//
//  Customer.swift
//  MoveMyStuff
//
//  Created by Yury on 8/6/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation

class Customer {
    
    static var sharedInstance = Customer()
    
    private init() {}
    
    var id: String?    = nil
    var email: String? = nil
    var name: String?  = nil
}
