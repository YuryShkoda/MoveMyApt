//
//  Customer.swift
//  moveMyApt
//
//  Created by Yury on 8/6/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation

struct Customer {
    
    let id: String
    var email: String
    var name: String
    
    init(id: String, email: String, name: String) {
        self.id = id
        self.email = email
        self.name = name
    }
}
