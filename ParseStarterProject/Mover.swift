//
//  Mover.swift
//  MoveMyStuff
//
//  Created by Yury on 8/6/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation

struct Mover {
    
    let id: String
    var email: String
    var name: String
    var rating: Double
    var isActive: Bool
    
    init(id: String, email: String, name: String, rating: Double, isActive: Bool) {
        
        self.id = id
        self.email = email
        self.name = name
        self.rating = rating
        self.isActive = isActive
    }
}
