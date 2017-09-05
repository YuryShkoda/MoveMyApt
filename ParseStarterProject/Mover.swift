//
//  Mover.swift
//  MoveMyStuff
//
//  Created by Yury on 8/6/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation

class Mover {
    
    static var sharedInstance = Mover()
    
    private init() {}
    
    var id: String?     = nil
    var email: String?  = nil
    var isActive: Bool? = nil
    var name: String?   = nil
}
